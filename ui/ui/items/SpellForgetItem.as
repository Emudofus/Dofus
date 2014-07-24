package ui.items
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2components.Label;
   import d2components.ButtonContainer;
   import d2components.Slot;
   import d2hooks.*;
   
   public class SpellForgetItem extends Object
   {
      
      public function SpellForgetItem() {
         super();
      }
      
      public var output:Object;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      private var _grid:Object;
      
      private var _data;
      
      private var _selected;
      
      public var lbl_spellName:Label;
      
      public var lbl_spellLvl:Label;
      
      public var btn_spell:ButtonContainer;
      
      public var slot_icon:Slot;
      
      public function main(oParam:Object = null) : void {
         this.uiApi.addComponentHook(this.slot_icon,"onRollOver");
         this.uiApi.addComponentHook(this.slot_icon,"onRollOut");
         this.slot_icon.cacheAsBitmap = true;
         this._grid = oParam.grid;
         this._data = oParam.data;
         this._selected = oParam.selected;
         this.slot_icon.removeDropSource = this.removeDropSourceFunction;
         this.slot_icon.processDrop = this.processDropFunction;
         this.slot_icon.dropValidator = this.dropValidatorFunction;
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
         var spell:Object = null;
         if(data)
         {
            spell = this.dataApi.getSpell(data.id);
            this.lbl_spellName.text = spell.name;
            this.lbl_spellLvl.text = data.spellLevel;
            this.slot_icon.data = data;
            this.slot_icon.selected = false;
            this.btn_spell.selected = selected;
            this.btn_spell.state = selected?this.sysApi.getEnum("com.ankamagames.berilia.enums.StatesEnum").STATE_SELECTED:this.sysApi.getEnum("com.ankamagames.berilia.enums.StatesEnum").STATE_NORMAL;
         }
         else
         {
            this.lbl_spellName.text = "";
            this.lbl_spellLvl.text = "";
            this.slot_icon.data = null;
            this.btn_spell.disabled = true;
         }
      }
      
      public function dropValidatorFunction(target:Object, iSlotData:Object, source:Object) : Boolean {
         return false;
      }
      
      public function removeDropSourceFunction(target:Object) : void {
      }
      
      public function processDropFunction(iSlotDataHolder:Object, data:Object, source:Object) : void {
         iSlotDataHolder.data = this._data;
      }
      
      public function select(b:Boolean) : void {
         this.btn_spell.selected = b;
      }
      
      public function onRollOver(target:Object) : void {
         if(this._data)
         {
            this.uiApi.showTooltip(this._data,target,false,"standard",8);
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
   }
}
