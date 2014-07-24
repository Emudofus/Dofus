package ui
{
   import d2api.DataApi;
   import d2api.ChatApi;
   import d2components.ColorPicker;
   import d2components.ButtonContainer;
   import d2components.Label;
   import d2components.ComboBox;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import types.ConfigProperty;
   import d2hooks.*;
   import d2actions.*;
   import flash.geom.ColorTransform;
   
   public class ConfigChat extends ConfigUi
   {
      
      public function ConfigChat() {
         super();
      }
      
      public var output:Object;
      
      public var dataApi:DataApi;
      
      public var chatApi:ChatApi;
      
      public var modCommon:Object;
      
      private var _colorTexture:Object;
      
      private var _oldColors:Array;
      
      private var _channels:Array;
      
      public var cp_colorPk:ColorPicker;
      
      public var btn_resetColors:ButtonContainer;
      
      public var btn_showNotifications:ButtonContainer;
      
      public var btn_resetNotifications:ButtonContainer;
      
      public var lbl_title:Object;
      
      public var lbl_sample:Label;
      
      public var cb_channel:ComboBox;
      
      public function main(args:*) : void {
         this.btn_resetColors.soundId = SoundEnum.CHECKBOX_CHECKED;
         var properties:Array = new Array();
         properties.push(new ConfigProperty("btn_letLivingObjectTalk","letLivingObjectTalk","chat"));
         properties.push(new ConfigProperty("btn_filterInsult","filterInsult","chat"));
         properties.push(new ConfigProperty("btn_showTime","showTime","chat"));
         properties.push(new ConfigProperty("btn_channelLocked","channelLocked","chat"));
         properties.push(new ConfigProperty("btn_chatExpertMode","chatExpertMode","chat"));
         properties.push(new ConfigProperty("btn_showShortcut","showShortcut","chat"));
         properties.push(new ConfigProperty("btn_showInfoPrefix","showInfoPrefix","chat"));
         properties.push(new ConfigProperty("btn_smileysAutoclosed","smileysAutoclosed","chat"));
         properties.push(new ConfigProperty("btn_displayTooltips","displayTooltips","dofus"));
         properties.push(new ConfigProperty("btn_confirmItemDrop","confirmItemDrop","dofus"));
         properties.push(new ConfigProperty("btn_showNotifications","showNotifications","dofus"));
         init(properties);
         this.initChatOptions();
      }
      
      override public function reset() : void {
         super.reset();
         init(_properties);
         this.initChatOptions();
      }
      
      public function unload() : void {
         sysApi.dispatchHook(UpdateChatOptions);
      }
      
      private function initChatOptions() : void {
         var chan:* = undefined;
         this._channels = new Array();
         for each(chan in this.dataApi.getAllChatChannels())
         {
            if(chan.id != sysApi.getEnum("com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum").PSEUDO_CHANNEL_FIGHT_LOG)
            {
               this._channels.push(chan);
            }
         }
         this.cb_channel.dataProvider = this._channels;
         this.cb_channel.value = this._channels[0];
         this.cb_channel.dataNameField = "name";
      }
      
      private function saveOptions() : void {
      }
      
      private function undoOptions() : void {
         var color:* = undefined;
         var i:* = undefined;
         var colorId:uint = 0;
         var colors:Array = new Array();
         for each(color in this.chatApi.getChatColors())
         {
            colors.push(color);
         }
         for each(i in this._channels)
         {
            configApi.setConfigProperty("chat","channelColor" + i.id,colors[i.id]);
         }
         this.cb_channel.dataProvider = this._channels;
         colorId = configApi.getConfigProperty("chat","channelColor" + this.cb_channel.value.id);
         this.cp_colorPk.color = colorId;
         this.lbl_sample.colorText = colorId;
      }
      
      private function selectColor() : void {
      }
      
      override public function onRelease(target:Object) : void {
         super.onRelease(target);
         switch(target)
         {
            case this.btn_resetColors:
               this.undoOptions();
               break;
            case this.btn_showNotifications:
               sysApi.dispatchHook(RefreshTips);
               break;
            case this.btn_resetNotifications:
               sysApi.sendAction(new NotificationReset());
               break;
         }
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         var color:uint = 0;
         switch(target)
         {
            case this.cb_channel:
               color = configApi.getConfigProperty("chat","channelColor" + this.cb_channel.value.id);
               this.lbl_sample.colorText = color;
               this.cp_colorPk.color = color;
               break;
         }
      }
      
      public function onColorChange(target:Object) : void {
         var t:ColorTransform = null;
         var color:uint = this.cp_colorPk.color;
         if(color != configApi.getConfigProperty("chat","channelColor" + this.cb_channel.value.id))
         {
            if(!this._colorTexture)
            {
               this._colorTexture = this.cb_channel.container.uiClass.tx_color;
            }
            t = new ColorTransform();
            t.color = color;
            this._colorTexture.transform.colorTransform = t;
            configApi.setConfigProperty("chat","channelColor" + this.cb_channel.value.id,color);
            this.lbl_sample.colorText = color;
         }
      }
      
      public function onRollOver(target:Object) : void {
         var tooltipText:String = null;
         var point:uint = 7;
         var relPoint:uint = 1;
         switch(target)
         {
            case this.btn_resetNotifications:
               tooltipText = uiApi.getText("ui.option.resetHints");
               break;
         }
         uiApi.showTooltip(uiApi.textTooltipInfo(tooltipText),target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:Object) : void {
         uiApi.hideTooltip();
      }
   }
}
