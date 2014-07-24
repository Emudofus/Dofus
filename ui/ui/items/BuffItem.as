package ui.items
{
   import d2hooks.*;
   import d2data.Spell;
   import d2components.Texture;
   import d2components.Label;
   import d2components.ButtonContainer;
   
   public class BuffItem extends Object
   {
      
      public function BuffItem(spellId:int, casterId:int, parentBoostUid:uint, endDelay:int, size:uint, css:String, ctr:Object, x:int) {
         super();
         if(endDelay > 0)
         {
            this._key = spellId + "#" + casterId + "#" + parentBoostUid + "#" + endDelay;
         }
         else
         {
            this._key = spellId + "#" + casterId + "#" + parentBoostUid;
         }
         this._buffs = new Array();
         this._spell = Api.dataApi.getSpell(spellId);
         this._ctr = ctr;
         this._size = size;
         var textureUri:String = Api.dataApi.getSpellWrapper(spellId).iconUri.toString();
         this.btn_buff = Api.uiApi.createContainer("ButtonContainer") as ButtonContainer;
         this.btn_buff.width = size;
         this.btn_buff.height = size;
         this.btn_buff.name = "buff_" + this.key;
         this.tx_buff = Api.uiApi.createComponent("Texture") as Texture;
         this.tx_buff.width = size;
         this.tx_buff.height = size;
         this.tx_buff.x = 0;
         this.tx_buff.y = 0;
         this.tx_buff.name = "tx_buff";
         this.tx_buff.uri = Api.uiApi.createUri(textureUri);
         this.tx_buff.finalize();
         this.lbl_cooldown_buff = Api.uiApi.createComponent("Label") as Label;
         this.lbl_cooldown_buff.height = 19;
         this.lbl_cooldown_buff.width = 19;
         this.lbl_cooldown_buff.fixedWidth = false;
         this.lbl_cooldown_buff.bgColor = 3355443;
         this.lbl_cooldown_buff.bgAlpha = 0.6;
         this.lbl_cooldown_buff.x = 0;
         this.lbl_cooldown_buff.y = 0;
         this.lbl_cooldown_buff.css = Api.uiApi.createUri(css);
         this.lbl_cooldown_buff.cssClass = "quantity";
         this.lbl_cooldown_buff.text = "+";
         this.lbl_cooldown_buff.fullWidth();
         this.cooldown = this._cooldown;
         this.btn_buff.addChild(this.tx_buff);
         this.btn_buff.addChild(this.lbl_cooldown_buff);
         var stateChangingProperties:Array = new Array();
         stateChangingProperties[Api.sysApi.getEnum("com.ankamagames.berilia.enums.StatesEnum").STATE_OVER] = new Array();
         stateChangingProperties[Api.sysApi.getEnum("com.ankamagames.berilia.enums.StatesEnum").STATE_OVER][this.tx_buff.name] = new Array();
         stateChangingProperties[Api.sysApi.getEnum("com.ankamagames.berilia.enums.StatesEnum").STATE_OVER][this.tx_buff.name]["luminosity"] = 1.5;
         this.btn_buff.changingStateData = stateChangingProperties;
         ctr.addChild(this.btn_buff);
      }
      
      public static function getKey(buff:Object) : String {
         if((buff.effects.hasOwnProperty("delay")) && (buff.effects.delay > 0))
         {
            return getDelayKey(buff);
         }
         return buff.castingSpell.spell.id + "#" + buff.castingSpell.casterId + "#" + buff.parentBoostUid;
      }
      
      public static function getDelayKey(buff:Object) : String {
         return buff.castingSpell.spell.id + "#" + buff.castingSpell.casterId + "#" + buff.parentBoostUid + "#" + getEndDelayTurn(buff);
      }
      
      public static function getEndDelayTurn(buff:Object) : int {
         if(buff.effects.hasOwnProperty("delay"))
         {
            return Api.fightApi.getTurnsCount() + buff.effects.delay;
         }
         return Api.fightApi.getTurnsCount();
      }
      
      private var _key:String;
      
      private var _buffs:Array;
      
      private var _spell:Spell;
      
      private var _parentBoostUid:int = 0;
      
      private var _cooldown:int = 0;
      
      private var _textureUri:Object;
      
      private var _ctr:Object;
      
      private var _size:int;
      
      private var tx_buff:Texture;
      
      private var lbl_cooldown_buff:Label;
      
      public var btn_buff:ButtonContainer;
      
      public function hasUid(boostUid:String) : Boolean {
         var buff:Object = null;
         for each(buff in this._buffs)
         {
            if(buff.uid == boostUid)
            {
               return true;
            }
         }
         return false;
      }
      
      public function set cooldown(value:int) : void {
         this._cooldown = value;
         if(this.lbl_cooldown_buff)
         {
            if(this._cooldown == -1)
            {
               this.lbl_cooldown_buff.text = "+";
               this.lbl_cooldown_buff.visible = true;
            }
            else if((this._cooldown == 0) || (this._cooldown == uint.MAX_VALUE))
            {
               this.lbl_cooldown_buff.text = "";
               this.lbl_cooldown_buff.visible = false;
            }
            else if(this._cooldown < -1)
            {
               this.lbl_cooldown_buff.text = "∞";
               this.lbl_cooldown_buff.visible = true;
            }
            else
            {
               this.lbl_cooldown_buff.text = this._cooldown.toString();
               this.lbl_cooldown_buff.visible = true;
            }
            
            
         }
      }
      
      public function get cooldown() : int {
         return this._cooldown;
      }
      
      public function get maxCooldown() : int {
         var buff:Object = null;
         if(this._cooldown != -1)
         {
            return this._cooldown;
         }
         var max:int = 0;
         for each(buff in this._buffs)
         {
            if((buff.duration > max) || (buff.duration < -1))
            {
               max = buff.duration;
            }
         }
         return max;
      }
      
      public function set textureUri(uri:Object) : void {
         this._textureUri = uri;
         if(this.tx_buff)
         {
            this.tx_buff.uri = this._textureUri;
         }
      }
      
      public function set x(value:int) : void {
         this.btn_buff.x = value;
      }
      
      public function get x() : int {
         return this.btn_buff.x;
      }
      
      public function set y(value:int) : void {
         this.btn_buff.y = value;
      }
      
      public function get y() : int {
         return this.btn_buff.y;
      }
      
      public function get width() : int {
         return this.btn_buff.width;
      }
      
      public function get height() : int {
         return this.btn_buff.height;
      }
      
      public function get key() : String {
         return this._key;
      }
      
      public function get buffs() : Array {
         return this._buffs;
      }
      
      public function get spell() : Spell {
         return this._spell;
      }
      
      public function get unusableNextTurn() : Boolean {
         var buff:Object = null;
         for each(buff in this._buffs)
         {
            if(!buff.unusableNextTurn)
            {
               return false;
            }
         }
         return true;
      }
      
      public function addBuff(buff:Object) : void {
         this._buffs.push(buff);
         if(buff.parentBoostUid != 0)
         {
            this._parentBoostUid = buff.parentBoostUid;
         }
         this.updateCooldown();
      }
      
      public function get parentBoostUid() : int {
         return this._parentBoostUid;
      }
      
      public function update(buff:Object) : void {
         this.updateCooldown();
      }
      
      public function removeBuff(buff:Object) : void {
         var i:int = 0;
         while(i < this._buffs.length)
         {
            if(this._buffs[i] == buff)
            {
               this._buffs.splice(i,1);
               this.updateCooldown();
               break;
            }
            i++;
         }
         if(this._buffs.length == 0)
         {
            this.remove();
         }
      }
      
      public function remove() : void {
         if((this.btn_buff) && (!this.btn_buff.isNull))
         {
            if(this._ctr.contains(this.btn_buff))
            {
               this._ctr.removeChild(this.btn_buff);
            }
            this.btn_buff.remove();
         }
      }
      
      public function updateCooldown() : void {
         var last:* = 0;
         var delay:* = 0;
         var buff:Object = null;
         var isSet:Boolean = false;
         for each(buff in this._buffs)
         {
            if((isSet) && (!(last == buff.duration)))
            {
               this.cooldown = -1;
            }
            if((delay == 0) || (buff.effects.delay < delay))
            {
               delay = buff.effects.delay;
            }
            last = buff.duration;
            isSet = true;
         }
         if(delay > 0)
         {
            this.cooldown = delay;
         }
         else
         {
            this.cooldown = last;
         }
         if(this.unusableNextTurn)
         {
            this.tx_buff.disabled = true;
         }
      }
   }
}
