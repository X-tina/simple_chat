node(:category) { |object| 
                       {
                         id: object.id,
                         category_name: object.name,
                         created_at: object.created_at,
                         updated_at: object.updated_at,
                       }
            }
