define ['underscore','base64'], (_, Base64) ->
    'use strict'

    parseDate: (date) ->
        if not _.isDate(date)
            #try
            #    date = new Date(date)
            #catch
            #    return date
            isoExp = /^\s*(\d{4})-(\d\d)-(\d\d)\s(\d\d):(\d\d):(\d\d)\s*$/
            parts = isoExp.exec(date)
            if parts
                date = new Date(parts[1], parts[2]-1, parts[3], parts[4], parts[5], parts[6])
            else
                return null
        return date

    decodeToken: (data) ->
        user_data = data.token.split('|')
        if user_data.length > 3
            user = $.parseJSON(Base64.decode(user_data[4].split(':')[1]))
            user.age = user_data[2].split(':')[1]
        else
            user = $.parseJSON(Base64.decode(user_data[0]))
            user.age = user_data[1]
        user.token = data.token
        user.business_id = if data.business_id == ''then false else data.business_id
        user.company_name = if data.company_name then data.company_name else ''
        user.max_age_days = data.max_age_days
        user.membership_use_deadline = data.membership_use_deadline
        user.invite_code = data.invite_code
        user
   

