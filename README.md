# README

I forgot to create this project with flag --api sorry :(

API

GET https://zip-codes-challenge.herokuapp.com/zip_codes/06140
Example Response:
{
    "data": {
        "id": "06140",
        "type": "zip_code",
        "attributes": {
            "zip_code": "06140",
            "locality": "CIUDAD DE MÉXICO",
            "federal_entity": "CIUDAD DE MÉXICO",
            "settlements": [
                {
                    "id": 37621,
                    "zip_code_id": "06140",
                    "code": "0884",
                    "name": "Condesa",
                    "description": null
                }
            ],
            "municipality": "CUAUHTÉMOC",
            "country": "MÉXICO"
        }
    }
}

GET https://zip-codes-challenge.herokuapp.com/zip_codes/00000
Example Response:
{
    "message": "Zip code does not exists."
}