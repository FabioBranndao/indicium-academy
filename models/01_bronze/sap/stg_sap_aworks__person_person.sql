with 

source as (

    select * from {{ source('raw', 'person_person') }}

),

person_person as (

    select
        businessentityid,
        persontype,
        namestyle,
        title,
        firstname,
        middlename,
        lastname,
        suffix,
        emailpromotion

    from source

)

select * from person_person