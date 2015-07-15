json.name event.name
json.friendly_id event.friendly_id
json.url v1_event_url(event)
json.created_at event.created_at

json.logo_original_url asset_url(event.logo.url)
json.logo_medium_url asset_url(event.logo.url(:medium))
json.logo_thumb_url asset_url(event.logo.url(:thumb))

json.logo_file_name event.logo_file_name
json.logo_content_type event.logo_content_type
json.logo_file_size event.logo_file_size
json.logo_updated_at event.logo_updated_at
