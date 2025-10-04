create or replace function handle_new_user()
returns trigger as $$
begin
    insert into public.profiles (
        id, 
        email, 
        first_name, 
        second_name, 
        birthday, 
        weight, 
        height, 
        gender,
        subscription_expiry
    )
    values (
        new.id,
        new.email,
        new.raw_user_meta_data->>'first_name',
        new.raw_user_meta_data->>'second_name',
        (new.raw_user_meta_data->>'birthday')::date,
        (new.raw_user_meta_data->>'weight')::float8,
        (new.raw_user_meta_data->>'height')::float8,
        (new.raw_user_meta_data->>'gender')::boolean,
        now() - interval '1 day'  -- تاريخ الاشتراك قبل يوم من الآن
    );

    return new;
end;
$$ language plpgsql security definer;
