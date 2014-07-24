package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.SocialApi;
   import d2api.PlayedCharacterApi;
   import d2api.DataApi;
   import d2api.ChatApi;
   import d2api.TimeApi;
   import d2components.TextArea;
   import d2components.ButtonContainer;
   import d2components.ComboBox;
   import d2hooks.*;
   import d2actions.*;
   
   public class Report extends Object
   {
      
      public function Report() {
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var modCommon:Object;
      
      public var socialApi:SocialApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var dataApi:DataApi;
      
      public var chatApi:ChatApi;
      
      public var timeApi:TimeApi;
      
      private var _playerID:uint = 0;
      
      private var _reasonName:Array;
      
      private var _playerName:String = "";
      
      private var _message:String = "";
      
      private var _fingerprint:String = "";
      
      private var _id:int = 0;
      
      private var _channel:int = 0;
      
      private var _timestamp:Number = 0;
      
      private var _type:uint = 0;
      
      public var lbl_text:TextArea;
      
      public var btn_close:ButtonContainer;
      
      public var btn_send:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public var btn_howTo:ButtonContainer;
      
      public var cb_reason:ComboBox;
      
      public function main(param:Object) : void {
         var currentReasaon:Object = null;
         var chatSentence:Object = null;
         var abuseReason:Object = null;
         var reasonObject:Object = null;
         this.uiApi.addComponentHook(this.cb_reason,"onRelease");
         this.uiApi.addComponentHook(this.btn_send,"onRelease");
         this.uiApi.addComponentHook(this.cb_reason,"onSelectItem");
         if((param.playerID is uint) && (param.playerName is String))
         {
            this._playerID = param.playerID;
            this._playerName = param.playerName;
            this._type = 1;
         }
         if((!(param.context == null)) && (param.context.hasOwnProperty("fingerprint")) && (param.context.hasOwnProperty("timestamp")))
         {
            chatSentence = this.socialApi.getChatSentence(param.context.timestamp,param.context.fingerprint);
            if(chatSentence != null)
            {
               this._message = chatSentence.baseMsg;
               this._fingerprint = chatSentence.fingerprint;
               this._id = param.context.id;
               this._channel = chatSentence.channel;
               this._timestamp = param.context.timestamp;
               this._type = 0;
            }
         }
         var reasonList:Object = this.dataApi.getAllAbuseReasons();
         var cbProvider:Array = new Array();
         var reasonListSize:int = reasonList.length;
         var i:int = 0;
         while(i < reasonListSize)
         {
            abuseReason = reasonList[i];
            if(abuseReason != null)
            {
               if((abuseReason._mask >> this._type & 1) == 1)
               {
                  reasonObject = 
                     {
                        "label":abuseReason.name,
                        "abuseReasonId":abuseReason._abuseReasonId,
                        "mask":abuseReason._mask,
                        "reasonTextId":abuseReason._reasonTextId
                     };
                  cbProvider.push(reasonObject);
               }
            }
            i++;
         }
         this.cb_reason.dataProvider = cbProvider;
         this.cb_reason.value = cbProvider[0];
         var header:String = this.sysApi.getCurrentServer().name + " - " + this.timeApi.getDate(this._timestamp) + " " + this.timeApi.getClock(this._timestamp,true);
         if(this._message)
         {
            this.lbl_text.text = header + " - " + this._playerName + this.uiApi.getText("ui.common.colon") + this.chatApi.getStaticHyperlink(this._message);
         }
         else
         {
            this.lbl_text.text = header + " - " + this._playerName;
         }
      }
      
      public function unload() : void {
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi("report");
               break;
            case this.btn_send:
               this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.social.reportValidation"),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onValidation],this.onValidation);
               break;
            case this.btn_help:
               this.sysApi.goToUrl(this.uiApi.getText("ui.link.phishing"));
               break;
            case this.btn_howTo:
               this.sysApi.goToUrl(this.uiApi.getText("ui.link.howToReport"));
               break;
         }
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         switch(target)
         {
            case this.cb_reason:
               if(this.cb_reason.value.abuseReasonId == 4)
               {
                  this.btn_help.visible = true;
               }
               else
               {
                  this.btn_help.visible = false;
               }
               break;
         }
      }
      
      public function onValidation() : void {
         if(this._type == 1)
         {
            this.sysApi.sendAction(new CharacterReport(this._playerID,this.cb_reason.value.abuseReasonId));
         }
         else if(this._type == 0)
         {
            this.sysApi.sendAction(new ChatReport(this._playerID,this.cb_reason.value.abuseReasonId,this._playerName,this._channel,this._fingerprint,this._message,this._timestamp));
         }
         
         this.sysApi.sendAction(new AddIgnored(this._playerName));
         this.sysApi.dispatchHook(TextInformation,this.uiApi.getText("ui.social.reportFeedBack",this._playerName),10,this.timeApi.getTimestamp());
         this.uiApi.unloadUi("report");
      }
   }
}
