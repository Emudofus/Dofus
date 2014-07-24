package ui.items
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.PlayedCharacterApi;
   import d2api.MountApi;
   import d2components.ButtonContainer;
   import d2components.Label;
   import d2components.EntityDisplayer;
   import d2hooks.*;
   
   public class GiftCharacterSelectionItem extends Object
   {
      
      public function GiftCharacterSelectionItem() {
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var mountApi:MountApi;
      
      private var _grid:Object;
      
      private var _data;
      
      private var _selected:Boolean;
      
      public var btn_character:ButtonContainer;
      
      public var lbl_name:Label;
      
      public var lbl_level:Label;
      
      public var ed_avatar:EntityDisplayer;
      
      public function main(oParam:Object = null) : void {
         this._grid = oParam.grid;
         this._data = oParam.data;
         this._selected = false;
         if(this.data)
         {
            this.uiApi.addComponentHook(this.btn_character,"onRollOver");
            this.uiApi.addComponentHook(this.btn_character,"onRelease");
            this.uiApi.addComponentHook(this.btn_character,"onRollOut");
         }
         else
         {
            this.uiApi.me().visible = false;
         }
         this.ed_avatar.scale = 1.5;
         this.ed_avatar.yOffset = 20;
         this.ed_avatar.setAnimationAndDirection("AnimArtwork",1);
         this.ed_avatar.view = "timeline";
         this.update(this._data,this._selected);
      }
      
      public function unload() : void {
      }
      
      public function get data() : * {
         return this._data;
      }
      
      public function get selected() : Boolean {
         return this._selected;
      }
      
      public function update(data:*, selected:Boolean) : void {
         if(!data)
         {
            return;
         }
         this._selected = selected;
         this.btn_character.selected = selected;
         this.ed_avatar.width = 49;
         this.ed_avatar.height = 71;
         this.lbl_name.text = data.name;
         this.lbl_level.text = data.level;
         this.ed_avatar.look = this.mountApi.getRiderEntityLook(data.entityLook);
         this._data = data;
      }
      
      public function select(b:Boolean) : void {
         this.btn_character.selected = b;
      }
      
      public function onRollOver(target:Object) : void {
         switch(target)
         {
            case this.btn_character:
               this.btn_character.bgAlpha = 1;
               break;
         }
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btn_character:
               this.btn_character.bgAlpha = 1;
               break;
         }
      }
      
      public function onRollOut(target:Object) : void {
         switch(target)
         {
            case this.btn_character:
               if(this._selected)
               {
                  this.btn_character.bgAlpha = 1;
               }
               else
               {
                  this.btn_character.bgAlpha = 0;
               }
               break;
         }
      }
   }
}
