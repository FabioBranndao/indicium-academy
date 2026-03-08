with 

source as (

    select * from {{ source('raw', 'person_stateprovince') }}

),

person_stateprovince as (

    select
        stateprovinceid,
        stateprovincecode,
        countryregioncode,
        isonlystateprovinceflag,
        name as dsc_estado

    from source

)

select * from person_stateprovince