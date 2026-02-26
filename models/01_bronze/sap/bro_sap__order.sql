with
    raw_order as (
        select *
        from {{source('sap','orders')}}
    )

select *
from raw_order
