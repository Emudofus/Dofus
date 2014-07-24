package ui
{
   import d2api.UiApi;
   import d2api.ExternalNotificationApi;
   import d2api.ConfigApi;
   import d2api.SystemApi;
   import d2api.UtilApi;
   import d2components.GraphicContainer;
   import d2components.Label;
   import d2components.ButtonContainer;
   import d2components.Texture;
   import d2components.EntityDisplayer;
   import d2enums.ComponentHookList;
   import d2hooks.ContactLook;
   import d2actions.ContactLookRequestById;
   
   public class ExternalNotification extends Object
   {
      
      public function ExternalNotification() {
         super();
      }
      
      private static const DEBUG:Boolean = false;
      
      private var _instanceId:String;
      
      private const TITLE_FONT_SIZE:uint = 12;
      
      private const MESSAGE_FONT_SIZE:uint = 12;
      
      private var _entityId:int = -1;
      
      public var uiApi:UiApi;
      
      public var extNotifApi:ExternalNotificationApi;
      
      public var configApi:ConfigApi;
      
      public var sysApi:SystemApi;
      
      public var utilApi:UtilApi;
      
      public var ctr_extNotif:GraphicContainer;
      
      public var lbl_title:Label;
      
      public var lbl_notif:Label;
      
      public var btn_close:ButtonContainer;
      
      public var tx_slot:Texture;
      
      public var tx_iconBg:Texture;
      
      public var tx_icon:Texture;
      
      public var ed_player:EntityDisplayer;
      
      public function main(pDisplayData:Object) : void {
         this._instanceId = this.uiApi.me().name;
         if(this.configApi.getConfigProperty("dofus","notificationsAlphaWindows") == true)
         {
            this.ctr_extNotif.alpha = 0.9;
         }
         this.ctr_extNotif.mouseChildren = this.ctr_extNotif.handCursor = true;
         this.uiApi.addComponentHook(this.ctr_extNotif,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.ctr_extNotif,ComponentHookList.ON_ROLL_OVER);
         if(pDisplayData.title)
         {
            this.setLabelText(this.lbl_title,pDisplayData.title,this.TITLE_FONT_SIZE,this.lbl_title.cssClass);
         }
         if(pDisplayData.entityContactData)
         {
            this._entityId = pDisplayData.entityContactData.id;
            this.ed_player.visible = false;
            this.uiApi.addComponentHook(this.ed_player,"onEntityReady");
            this.sysApi.addHook(ContactLook,this.onContactLook);
            this.sysApi.sendAction(new ContactLookRequestById(pDisplayData.entityContactData.contactCategory,pDisplayData.entityContactData.id));
         }
         else if(pDisplayData.iconPath)
         {
            if(pDisplayData.iconBg)
            {
               this.tx_iconBg.uri = this.uiApi.createUri(pDisplayData.iconPath + pDisplayData.iconBg + ".png");
            }
            this.tx_icon.uri = this.uiApi.createUri(pDisplayData.iconPath + pDisplayData.icon + ".png");
         }
         
         if(pDisplayData.cssClass != "p")
         {
            this.lbl_notif.cssClass = pDisplayData.cssClass;
         }
         if(pDisplayData.css != "normal")
         {
            this.lbl_notif.css = this.uiApi.createUri(this.uiApi.me().getConstant("css") + "/" + pDisplayData.css + ".css");
         }
         this.setLabelText(this.lbl_notif,pDisplayData.message,this.MESSAGE_FONT_SIZE,pDisplayData.cssClass);
      }
      
      private function setLabelText(pLabel:Label, pMsg:String, pFontSize:uint, pCssClass:String) : void {
         if(this.sysApi.getCurrentLanguage() == "ja")
         {
            pLabel.useEmbedFonts = false;
         }
         pLabel.setCssSize(pFontSize,pCssClass);
         pLabel.appendText(pMsg,pCssClass);
      }
      
      public function onContactLook(pEntityId:uint, pEntityName:String, pEntityLook:Object) : void {
         if(this._entityId == pEntityId)
         {
            this.ed_player.scale = 1;
            this.ed_player.xOffset = this.ed_player.yOffset = 0;
            this.ed_player.withoutMount = true;
            this.ed_player.animation = "AnimStatique";
            this.ed_player.direction = 3;
            this.ed_player.look = pEntityLook;
         }
      }
      
      public function onEntityReady(pEntityDisplayer:Object) : void {
         var headBounds:Object = null;
         var entityBounds:Object = null;
         var yOffset:* = NaN;
         if(this.ed_player == pEntityDisplayer)
         {
            headBounds = this.ed_player.getSlotBounds("Tete");
            if(headBounds)
            {
               entityBounds = this.ed_player.getEntityBounds();
               yOffset = entityBounds.height / 2;
               if(headBounds.y > 0)
               {
                  yOffset = yOffset - 10;
               }
               this.ed_player.scale = 2;
               this.ed_player.yOffset = yOffset;
               this.ed_player.updateMask();
               this.ed_player.updateScaleAndOffsets();
            }
            this.ed_player.visible = true;
         }
      }
      
      public function onRelease(pTarget:Object) : void {
         switch(pTarget)
         {
            case this.btn_close:
               this.extNotifApi.removeExternalNotification(this._instanceId);
               break;
            case this.ctr_extNotif:
               this.extNotifApi.removeExternalNotification(this._instanceId,true);
               break;
         }
      }
      
      public function onRollOver(pTarget:Object) : void {
         if(pTarget == this.ctr_extNotif)
         {
            this.extNotifApi.resetExternalNotificationDisplayTimeout(this._instanceId);
         }
      }
   }
}
