package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.StorageApi;
   import d2api.DataApi;
   import d2data.ItemWrapper;
   import d2components.GraphicContainer;
   import d2components.ButtonContainer;
   import d2components.Grid;
   import d2components.Slot;
   import d2components.Texture;
   import d2components.Label;
   import d2enums.ShortcutHookListEnum;
   import d2hooks.*;
   import d2actions.*;
   import flash.geom.ColorTransform;
   
   public class LivingObject extends Object
   {
      
      public function LivingObject() {
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var storageApi:StorageApi;
      
      public var modCommon:Object;
      
      public var dataApi:DataApi;
      
      private var _item:ItemWrapper;
      
      public var mainCtr:GraphicContainer;
      
      public var ctr_menu:GraphicContainer;
      
      public var ctr_look:GraphicContainer;
      
      public var btn_closeLook:ButtonContainer;
      
      public var btn_lookOk:ButtonContainer;
      
      public var grid_look:Grid;
      
      public var btn_close:ButtonContainer;
      
      public var btn_look:ButtonContainer;
      
      public var btn_destroy:ButtonContainer;
      
      public var btn_feed:ButtonContainer;
      
      public var slot_icon:Slot;
      
      public var tx_xp:Texture;
      
      public var tx_xpBack:Texture;
      
      public var lbl_level:Label;
      
      public var lbl_mood:Label;
      
      public var lbl_date:Label;
      
      public function main(param:Object) : void {
         this.uiApi.addComponentHook(this.btn_lookOk,"onRelease");
         this.uiApi.addComponentHook(this.btn_closeLook,"onRelease");
         this.uiApi.addComponentHook(this.btn_close,"onRelease");
         this.uiApi.addComponentHook(this.btn_look,"onRelease");
         this.uiApi.addComponentHook(this.btn_destroy,"onRelease");
         this.uiApi.addComponentHook(this.btn_feed,"onRelease");
         this.uiApi.addComponentHook(this.tx_xpBack,"onRollOver");
         this.uiApi.addComponentHook(this.tx_xpBack,"onRollOut");
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortCut);
         this.sysApi.addHook(EquipmentObjectMove,this.onEquipmentObjectMove);
         this.sysApi.addHook(LivingObjectUpdate,this.onLivingObjectUpdate);
         this.sysApi.addHook(LivingObjectFeed,this.onLivingObjectFeed);
         this.sysApi.addHook(d2hooks.LivingObjectDissociate,this.onLivingObjectDissociate);
         this.sysApi.addHook(LivingObjectAssociate,this.onLivingObjectAssociate);
         this._item = param.item;
         this.updateLivingObjectInfos();
      }
      
      private function updateLivingObjectInfos() : void {
         var xpMax:int = this._item.livingObjectMaxXp;
         if(xpMax == -1)
         {
            this.tx_xp.width = 112;
         }
         else
         {
            this.tx_xp.width = int(this._item.livingObjectXp / xpMax * 112);
         }
         this.tx_xp.transform.colorTransform = new ColorTransform(1,1,1,1,-76,-10,33,0);
         if(this._item.type.id == 113)
         {
            this.btn_destroy.disabled = true;
            this.btn_feed.disabled = true;
         }
         else
         {
            this.btn_destroy.disabled = false;
            this.btn_feed.disabled = false;
         }
         this.lbl_level.text = this._item.livingObjectLevel.toString();
         this.lbl_date.text = this._item.livingObjectFoodDate;
         this.slot_icon.data = this._item;
         var mood:uint = this._item.livingObjectMood;
         if(mood == 0)
         {
            this.lbl_mood.text = this.uiApi.getText("ui.common.lean");
         }
         else if(mood == 1)
         {
            this.lbl_mood.text = this.uiApi.getText("ui.common.satisfied");
         }
         else if(mood == 2)
         {
            this.lbl_mood.text = this.uiApi.getText("ui.common.fat");
         }
         else
         {
            this.lbl_mood.text = "Error";
         }
         
         
      }
      
      public function unload() : void {
      }
      
      private function onEquipmentObjectMove(item:ItemWrapper, oldPosition:uint) : void {
         if((item) && (item.objectUID == this._item.objectUID))
         {
            this._item = item;
            this.updateLivingObjectInfos();
         }
      }
      
      private function onLivingObjectUpdate(item:ItemWrapper) : void {
         this._item = item;
         this.updateLivingObjectInfos();
      }
      
      private function onLivingObjectFeed(item:ItemWrapper) : void {
         this._item = item;
         this.updateLivingObjectInfos();
      }
      
      private function onLivingObjectDissociate(item:Object) : void {
         this.uiApi.unloadUi("livingObject");
      }
      
      private function onLivingObjectAssociate(item:ItemWrapper) : void {
         this._item = item;
         this.updateLivingObjectInfos();
      }
      
      private function initLook(init:Boolean) : void {
         var provider:Object = null;
         if(init)
         {
            this.ctr_look.visible = true;
            provider = this.dataApi.getLivingObjectSkins(this._item);
            this.grid_look.dataProvider = provider;
            this.grid_look.selectedIndex = this._item.livingObjectSkin - 1;
         }
         else
         {
            this.ctr_look.visible = false;
         }
      }
      
      public function onRelease(target:Object) : void {
         if(target == this.btn_close)
         {
            this.uiApi.unloadUi("livingObject");
         }
         else if(target == this.btn_look)
         {
            this.initLook(true);
         }
         else if(target == this.btn_lookOk)
         {
            this.sysApi.sendAction(new LivingObjectChangeSkinRequest(this._item.objectUID,this._item.position,this.grid_look.selectedIndex + 1));
            this.initLook(false);
         }
         else if(target == this.btn_closeLook)
         {
            this.initLook(false);
         }
         else if(target == this.btn_destroy)
         {
            this.sysApi.sendAction(new d2actions.LivingObjectDissociate(this._item.objectUID,this._item.position));
         }
         else if(target == this.btn_feed)
         {
            this.ctr_look.visible = false;
            this.sysApi.dispatchHook(OpenFeed,this._item);
         }
         
         
         
         
         
      }
      
      public function onRollOver(target:Object) : void {
         var textTooltip:String = null;
         var xpMax:* = 0;
         var pos1:int = 7;
         var pos2:int = 1;
         var offset:int = 0;
         if(target == this.tx_xpBack)
         {
            xpMax = this._item.livingObjectMaxXp;
            if(xpMax == -1)
            {
               textTooltip = String(this._item.livingObjectXp);
            }
            else
            {
               textTooltip = this._item.livingObjectXp + " / " + xpMax;
            }
         }
         this.uiApi.showTooltip(this.uiApi.textTooltipInfo(textTooltip),target,false,"standard",pos1,pos2,offset,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      private function onShortCut(s:String) : Boolean {
         if(s == ShortcutHookListEnum.CLOSE_UI)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return true;
         }
         return false;
      }
   }
}
