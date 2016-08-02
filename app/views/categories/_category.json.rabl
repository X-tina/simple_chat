node(:category) { |object| 
                       {
                         id: object.id,
                         category_name: object.name,
                         created_at: object.created_at,
                         updated_at: object.updated_at
                       }

            }

node(:images) { |object| partial 'images/_image.json.rabl', :object => object.images }
