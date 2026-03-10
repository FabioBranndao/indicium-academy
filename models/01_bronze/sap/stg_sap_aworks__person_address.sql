with 
    source as (

        select * from {{ source('raw', 'person_address') }}

    ),

    person_address as (

        select
            addressid,
            addressline1,
            city,
            stateprovinceid,
            postalcode

        from source

    )

    select * from person_address