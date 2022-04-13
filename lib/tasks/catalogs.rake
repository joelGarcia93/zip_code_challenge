require 'csv'

namespace :catalogs do
	# change this to your own PC PATH
	PATH = '/Users/joelgarcia/Documents/catalogs_sat'

	# Challenge #1

	# this url is for developers to setup information locally, here you can find SAT catalogs
	# download the catalogs and change the PATH to your own
	# https://www.dropbox.com/s/ch486l0xvr3evlr/challenge.zip?dl=0
	
  
	# SAT catalog
	task :country => :environment do
		ActiveRecord::Base.connection.execute("copy countries(code2,name,code) FROM '#{PATH}/countries.csv' DELIMITER ',' CSV")
	end

    # SAT catalog in array
	task :state => :environment do
		countries = Country.all.pluck(:code2,:id).to_h
		records = []
		[
			['AGU','MX','Aguascalientes', 'AG'],
			['BCN',	'MX', 'Baja California', 'BC'],
			['BCS', 'MX', 'Baja California Sur', 'BS'],
			['CAM', 'MX', 'Campeche', 'CM'],
			['CHP', 'MX', 'Chiapas', 'CS'],
			['CHH', 'MX', 'Chihuahua', 'CH'],
			['COA', 'MX', 'Coahuila', 'CO'],
			['COL', 'MX', 'Colima', 'CL'],
			['DIF', 'MX', 'Ciudad de México', 'DF'],
			['DUR', 'MX', 'Durango', 'DG'],
			['GUA', 'MX', 'Guanajuato', 'GT'],
			['GRO', 'MX', 'Guerrero', 'GR'],
			['HID',	'MX', 'Hidalgo', 'HG'],
			['JAL', 'MX', 'Jalisco', 'JA'],
			['MEX', 'MX', 'Estado de México', 'EM'],
			['MIC', 'MX', 'Michoacán', 'MI'],
			['MOR', 'MX', 'Morelos', 'MO'],
			['NAY', 'MX', 'Nayarit', 'NA'],
			['NLE', 'MX', 'Nuevo León', 'NL'],
			['OAX', 'MX', 'Oaxaca', 'OA'],
			['PUE', 'MX', 'Puebla', 'PU'],
			['QUE', 'MX', 'Querétaro', 'QT'],
			['ROO', 'MX', 'Quintana Roo', 'QR'],
			['SLP', 'MX', 'San Luis Potosí', 'SL'],
			['SIN', 'MX', 'Sinaloa', 'SI'],
			['SON', 'MX', 'Sonora', 'SO'],
			['TAB', 'MX', 'Tabasco', 'TB'],
			['TAM', 'MX', 'Tamaulipas', 'TM'],
			['TLA', 'MX', 'Tlaxcala', 'TL'],
			['VER', 'MX', 'Veracruz', 'VE'],
			['YUC', 'MX', 'Yucatán', 'YU'],
			['ZAC', 'MX', 'Zacatecas', 'ZA']
		].each do |element|
			country_id = countries[element[1]]
			state = State.new(id: "#{element[0]}", country_id: country_id, code: "#{element[0]}", name: "#{element[2]}", code2: "#{element[3]}")
			records.push(state)
		end
		State.import records
	end

  # SAT catalog
	task :municipality => :environment do
		ActiveRecord::Base.connection.execute("copy municipalities(code,state_id,name) FROM '#{PATH}/municipalities.csv' DELIMITER ',' CSV")
	end

	# SAT catalog
	task :zip_code => :environment do
		results = []
		path = "#{PATH}/zip_codes.csv" #Rails.root.join('app', 'lib', 'catalogs', 'zip_codes.csv')
		CSV.foreach(path, headers: false) do |row|
			next if row[2].blank?
			municipality = Municipality.find_by(state_id: row[1], code: row[2])
			zip_code = ZipCode.new(id: row[0], municipality: municipality, code: row[0], name: row[0])
			results.push(zip_code)
		end
		ZipCode.import results
	end

	# SAT catalog
	task :colony => :environment do
		ActiveRecord::Base.connection.execute("copy colonies(code,zip_code_id,name) FROM '#{PATH}/colonies.csv' DELIMITER ',' CSV")
	end

	# Challenge #2

	# merchants
	task :merchant => :environment do
		ActiveRecord::Base.connection.execute("copy merchants(id,name,email,cif) FROM '#{PATH}/merchants.csv' DELIMITER ',' CSV")
	end

	# shoppers
	task :shopper => :environment do
		ActiveRecord::Base.connection.execute("copy shoppers(id,name,email,nif) FROM '#{PATH}/shoppers.csv' DELIMITER ',' CSV")
	end

	# orders
	task :order => :environment do
		path = Rails.root.join('app', 'lib', 'catalogs', 'orders.csv')
		# creating temporary table to avoid 
		# PG::DatetimeFieldOverflow: ERROR:  date/time field value out of range issue on copy
		ActiveRecord::Base.connection.execute(<<-SQL
				CREATE TABLE pg_temp.orders_temporary(id int, merchant_id int, shopper_id int, 
				amount decimal(9,2), created_at varchar, completed_at varchar);
			SQL
		)

		# copy info from csv to temporary table
		ActiveRecord::Base.connection.execute(<<-SQL
			COPY orders_temporary(id,merchant_id,shopper_id,amount,created_at,completed_at) 
			FROM '#{path}' DELIMITER ',' CSV
			SQL
		)
		
		# inserting correct format info in final orders table
		ActiveRecord::Base.connection.execute(<<-SQL
				INSERT INTO public.orders(id,merchant_id,shopper_id,amount,created_at,completed_at)
				SELECT id,merchant_id,shopper_id,amount,to_date(created_at, 'DD/MM/YYYY'),to_date(completed_at, 'DD/MM/YYYY')
				FROM   pg_temp.orders_temporary;
			SQL
		)
	end
end