module ApplicationHelper
    def autoredirect_to(url)
        link = tag.a(href: url,hstyle: 'display:none;', data: {controller: "booking-form"}, turbo_cache: false)
        turbo_stream.append_all('notification') { link }
    end
end
