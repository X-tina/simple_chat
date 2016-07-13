object @user

node(:meta) do 
             {
                success: true,

                count: 1,
                total_count: 1,
              }
            end
child({:@user => :data}, { object_root: false }) do
  extends('users/_user')
end