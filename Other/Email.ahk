;Email Selected Text

SendMail(user, pass, from, to, cc, bcc, subject, message)
{
	pmsg 			:= ComObjCreate("CDO.Message")
	pmsg.From 		:= from
	pmsg.To 		:= to
	pmsg.CC 		:= cc 		; "Somebody@somewhere.com, Other-somebody@somewhere.com"
	pmsg.BCC 		:= bcc		; Blind Carbon Copy, Invisable for all, same syntax as CC
	pmsg.Subject 	:= subject

	;You can use either Text or HTML for the body
	;pmsg.HtmlBody	:= "<html><head><title>Hello</title></head><body><h2>Hello</h2><p>Testing!</p></body></html>"
	pmsg.TextBody	:= message

	sAttach			:= "Path_Of_Attachment" ; can add multiple attachments, the delimiter is |

	fields							:= Object()
	fields.smtpserver				:= "smtp.gmail.com" ; specify your SMTP server
	fields.smtpserverport			:= 465				; 25
	fields.smtpusessl				:= True 			; False
	fields.sendusing				:= 2				; cdoSendUsingPort
	fields.smtpauthenticate			:= 1				; cdoBasic
	fields.sendusername				:= user
	fields.sendpassword				:= pass
	fields.smtpconnectiontimeout	:= 60
	schema							:= "http://schemas.microsoft.com/cdo/configuration/"


	pfld := pmsg.Configuration.Fields

	For field,value in fields
		pfld.Item(schema . field) := value
	pfld.Update()

	Loop, Parse, sAttach, |, %A_Space%%A_Tab%
		pmsg.AddAttachment(A_LoopField)
	pmsg.Send()
}