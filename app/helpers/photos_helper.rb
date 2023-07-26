module PhotosHelper

  def delete_button(photo)
    if current_user_can_edit?(photo)
      return button_to(fa_icon('trash'),
                       event_photo_path(photo.event, photo),
                       method: :delete,
                       data: { turbo_confirm: t('views.photos.destroy_confirm') },
                       class: 'btn btn-primary buffer-sm-top')
    end
    return ''
  end

end
