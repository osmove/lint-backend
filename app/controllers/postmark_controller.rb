class PostmarkController < ApplicationController
  def inbound

    @result = nil
    information = request.raw_post
    if information.present?
      @result = JSON.parse(information) rescue nil
      if @result.present?
        @message = Message.new
        @message.type = 'email'
        @message.provider = 'postmark'
        @message.raw_post = "#{information}"
        @message.name = @result['FromName']
        @message.email = @result['FromEmail']
        # @message.to_name = @result['ToFull']['Name'] rescue nil
        # @message.to_email = @result['ToFull']['Email'] rescue nil
        @message.to_email = @result['To']
        @message.subject = @result['Subject']
        @message.message = @result['TextBody']
        @message.save!
        respond_to do |format|
          if @message.save!
            format.json { render json: @message, status: :created }
          else
            format.json { render json: @message.errors, status: :unprocessable_entity }
          end
        end
      end
    else
      respond_to do |format|
        format.json { render json: "Error", status: :unprocessable_entity }
      end
    end

    #
    # @result = JSON.parse ('{"FromName": "Jimmy Douieb",
    #       "From": "jimmydouieb@gmail.com",
    #       "FromFull": {
    #         "Email": "jimmydouieb@gmail.com",
    #         "Name": "Jimmy Douieb",
    #         "MailboxHash": ""
    #       },
    #       "To": "cac0731fa0b48a89b6bb9d12bca81e59+24f5f1b33c54fc7383dcb331a82c259d@inbound.postmarkapp.com",
    #       "ToFull": [
    #         {
    #           "Email": "cac0731fa0b48a89b6bb9d12bca81e59+24f5f1b33c54fc7383dcb331a82c259d@inbound.postmarkapp.com",
    #           "Name": "",
    #           "MailboxHash": "24f5f1b33c54fc7383dcb331a82c259d"
    #         }
    #       ],
    #       "Cc": "",
    #       "CcFull": [],
    #       "Bcc": "",
    #       "BccFull": [],
    #       "OriginalRecipient": "cac0731fa0b48a89b6bb9d12bca81e59+24f5f1b33c54fc7383dcb331a82c259d@inbound.postmarkapp.com",
    #       "Subject": "Test 2",
    #       "MessageID": "e4e56f5e-f317-48b2-8ee1-b6a022b41fa6",
    #       "ReplyTo": "",
    #       "MailboxHash": "24f5f1b33c54fc7383dcb331a82c259d",
    #       "Date": "Wed, 23 Jan 2019 18:37:09 +0200",
    #       "TextBody": "\r\n",
    #       "HtmlBody": "<div dir=\"ltr\"><br></div>\r\n",
    #       "StrippedTextReply": "",
    #       "Tag": "",
    #       "Headers": [
    #         {
    #           "Name": "Return-Path",
    #           "Value": "<jimmydouieb@gmail.com>"
    #         },
    #         {
    #           "Name": "Received",
    #           "Value": "by p-pm-smtp-inbound02a-aws-uswest2a.inbound.postmarkapp.com (Postfix, from userid 994)id 65907C61D06; Wed, 23 Jan 2019 16:37:21 +0000 (UTC)"
    #         },
    #         {
    #           "Name": "X-Spam-Checker-Version",
    #           "Value": "SpamAssassin 3.4.0 (2014-02-07) onp-pm-smtp-inbound02a-aws-uswest2a"
    #         },
    #         {
    #           "Name": "X-Spam-Status",
    #           "Value": "No"
    #         },
    #         {
    #           "Name": "X-Spam-Score",
    #           "Value": "-0.1"
    #         },
    #         {
    #           "Name": "X-Spam-Tests",
    #           "Value": "DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_PASS"
    #         },
    #         {
    #           "Name": "Received-SPF",
    #           "Value": "pass (gmail.com ... _spf.google.com: Sender is authorized to use\'jimmydouieb@gmail.co\' in \'mfrom\' identity (mechanism \'include:_netblocks.google.com\' matched)) receiver=p-pm-smtp-inbound02a-aws-uswest2a; identity=mailfrom; envelope-from=\"jimmydouieb@gmail.com\"; helo=mail-io1-f49.google.com; client-ip=209.85.166.49"
    #         },
    #         {
    #           "Name": "Received",
    #           "Value": "from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))(No client certificate requested)by p-pm-smtp-inbound02a-aws-uswest2a.inbound.postmarkapp.com (Postfix) with ESMTPS id 1B92EC61D03for <cac0731fa0b48a89b6bb9d12bca81e59+24f5f1b33c54fc7383dcb331a82c259d@inbound.postmarkapp.com>; Wed, 23 Jan 2019 16:37:21 +0000 (UTC)"
    #         },
    #         {
    #           "Name": "Received",
    #           "Value": "by mail-io1-f49.google.com with SMTP id t24so2178834ioi.0        for <cac0731fa0b48a89b6bb9d12bca81e59+24f5f1b33c54fc7383dcb331a82c259d@inbound.postmarkapp.com>; Wed, 23 Jan 2019 08:37:21 -0800 (PST)"
    #         },
    #         {
    #           "Name": "DKIM-Signature",
    #           "Value": "v=1; a=rsa-sha256; c=relaxed/relaxed;        d=gmail.com; s=20161025;        h=mime-version:from:date:message-id:subject:to;        bh=iZ+B17rA3oaJAlyvv4cOIaZ8kUzFKq4qn1vQ6EqCwY8=;        b=TNtY6ZowvzIREVCqsu3/t2ibPvftTug9YYhEhgmTtyo1Vy4cnS1+73L1PAgfHFrQJI         HoiwaO9v1iJOtBgTMQcqe1iK8dbDXjTdh8g1To380Pdgk2Oq8vdj48A6nD5KA+z01Jz+         kCjTEtIOt29hBrR42hLtJ+txUb/HWxzcBbqMoNCqWijMt2bc0M3s45kmVu205iWRWSAt         YXAmVvsH5RHXOlkWdnolU/Z3H9TrjxfsLgQK04dT2Kmkr1oNIXExvOiSoFDcHy2dSQo2         58t9LZb/zJA8v9+x7fEremghzv25HxSdZ3LnS7VzpIXoOKYiC3DT4OpgnHZbfk0XboQg         Dvkg=="
    #         },
    #         {
    #           "Name": "X-Google-DKIM-Signature",
    #           "Value": "v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;        bh=iZ+B17rA3oaJAlyvv4cOIaZ8kUzFKq4qn1vQ6EqCwY8=;        b=F9+pS+fGSTv8h3mRwiSMRjvyhMnbYZ7428nX4OZAGOBqAcoC6lB0FRHXZfr3bhxc++         4HLrB8isHiyj+xDWmHkEJV9cDKwhUF/IMAr7RQGyUIBigUJIxjrIQdqITt9SU9yt75lB         NpeUpPL0Okd3A0ujP7hTVwaQU7DzNXnDJWQTFhCPaE0cLcsyvvGO9f5YQb3nWDzZMZXS         N425LYX6DjRxb6O0ANXEuLm1EcaD93k6GU5fIrmPypmJJ9uBP+eH+QxGWsPEmc8Nqs7P         IK4+B+2cXRf9/MyJ4e5mv0pSXSmi9Eun83yMCNcK3Czry3+kO6fI9TS2Kd9dBsPyRIN4         /4dg=="
    #         },
    #         {
    #           "Name": "X-Gm-Message-State",
    #           "Value": "AHQUAuZJlO1Kc991pLfUSBjzblWTrcXUUwWaK0AN/1ec7cxUMCiKzDmCXTtij5TxgN8CMQUiycvrCbhx3zrqAuelEgDqgUGPHQ=="
    #         },
    #         {
    #           "Name": "X-Google-Smtp-Source",
    #           "Value": "AHgI3IZLLRE3Wk6kRlUPMbL0esuarqFCDfo7+JDkENlTNocw6lNs2gTySlbyLSRyToLQnsNOEigte5EWrsSSthVFIM8="
    #         },
    #         {
    #           "Name": "X-Received",
    #           "Value": "by 2002:a5e:9604:: with SMTP id a4mr1673006ioq.123.1548261440417; Wed, 23 Jan 2019 08:37:20 -0800 (PST)"
    #         },
    #         {
    #           "Name": "MIME-Version",
    #           "Value": "1.0"
    #         },
    #         {
    #           "Name": "Message-ID",
    #           "Value": "<CAEOA1r3qA+0wFKGOwZuwsgG66sVh+LdLNUFdNgLb5-q=Wz-CZw@mail.gmail.com>"
    #         }
    #       ],
    #       "Attachments": []
    #     }')
  end
end
