with 

source as (

    select * from {{ source('raw', 'person_countryregion') }}

),

person_countryregion as (

    select
        countryregioncode,
        name as dsc_pais

    from source

)

select * from person_countryregion