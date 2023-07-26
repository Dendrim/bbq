$(this).ekkoLightbox({
                alwaysShowClose: true,
                onShown: function() {
                    console.log('Checking our the events huh?');
                },
                onNavigate: function(direction, itemIndex) {
                    console.log('Navigating '+direction+'. Current item: '+itemIndex);
                }
            });

$(document).on('click', '[data-toggle="lightbox"]', function(event) {
                $(this).ekkoLightbox();
                event.preventDefault();
            });
