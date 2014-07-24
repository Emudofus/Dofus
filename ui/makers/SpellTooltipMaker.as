package makers
{
   import d2hooks.*;
   import d2data.SpellWrapper;
   import blocks.TextTooltipBlock;
   import blocks.SpellTooltipBlock;
   import blocks.EffectTooltipBlock;
   import blocks.DescriptionTooltipBlock;
   
   public class SpellTooltipMaker extends Object
   {
      
      public function SpellTooltipMaker() {
         super();
      }
      
      public static var SPELL_TAB_MODE:Boolean;
      
      private var _param:paramClass;
      
      public function createTooltip(data:*, param:Object) : Object {
         var bg:String = null;
         var weapon:Object = null;
         var name:String = null;
         var shortcutColor:String = null;
         var dataApi:Object = Api.data;
         this._param = new paramClass();
         SPELL_TAB_MODE = (param) && (param.hasOwnProperty("spellTab")) && (param.spellTab);
         if(param)
         {
            if(param.hasOwnProperty("noBg"))
            {
               this._param.noBg = param.noBg;
            }
            if(param.hasOwnProperty("description"))
            {
               this._param.description = param.description;
            }
            if(param.hasOwnProperty("effects"))
            {
               this._param.effects = param.effects;
            }
            if(param.hasOwnProperty("smallSpell"))
            {
               this._param.smallSpell = param.smallSpell;
            }
            if(param.hasOwnProperty("CC_EC"))
            {
               this._param.CC_EC = param.CC_EC;
            }
            if(param.hasOwnProperty("name"))
            {
               this._param.name = param.name;
            }
            if(param.hasOwnProperty("header"))
            {
               this._param.header = param.header;
            }
            if(param.hasOwnProperty("contextual"))
            {
               this._param.contextual = param.contextual;
            }
            if(param.hasOwnProperty("shortcutKey"))
            {
               this._param.shortcutKey = param.shortcutKey;
            }
         }
         if((!this._param.CC_EC) && (!this._param.description) && (!this._param.effects) && (!this._param.name))
         {
            return "";
         }
         if(this._param.noBg)
         {
            bg = "chunks/base/base.txt";
         }
         else
         {
            bg = "chunks/base/baseWithBackground.txt";
         }
         var tooltip:Object = Api.tooltip.createTooltip(bg,"chunks/base/container.txt","chunks/base/separator.txt");
         var spellItem:Object = data;
         if((spellItem is SpellWrapper) && (spellItem.isSpellWeapon))
         {
            weapon = Api.player.getWeapon();
            if(weapon)
            {
               return new ItemTooltipMaker().createTooltip(weapon,
                  {
                     "noBg":this._param.noBg,
                     "header":this._param.name,
                     "effects":this._param.effects,
                     "contextual":this._param.contextual,
                     "conditions":true,
                     "description":this._param.description,
                     "CC_EC":this._param.CC_EC,
                     "shortcutKey":this._param.shortcutKey
                  });
            }
         }
         if(this._param.name)
         {
            name = spellItem.name;
            if(this._param.shortcutKey)
            {
               shortcutColor = Api.system.getConfigEntry("colors.shortcut");
               shortcutColor = shortcutColor.replace("0x","#");
               name = name + (" <font color=\'" + shortcutColor + "\'>(" + param.shortcutKey + ")</font>");
            }
            tooltip.addBlock(new TextTooltipBlock(name,
               {
                  "css":"[local.css]tooltip_title.css",
                  "cssClass":"spell"
               }).block);
         }
         if(this._param.header)
         {
            tooltip.addBlock(new SpellTooltipBlock(spellItem,param).block);
         }
         if(this._param.effects)
         {
            if((!spellItem.hideEffects) && (spellItem.effects.length))
            {
               tooltip.addBlock(new EffectTooltipBlock(spellItem.effects).block);
            }
            if((!spellItem.hideEffects) && (spellItem.criticalEffect.length))
            {
               tooltip.addBlock(new EffectTooltipBlock(spellItem.criticalEffect,422,true,true,true,true).block);
            }
         }
         if((this._param.description) && (spellItem.description))
         {
            tooltip.addBlock(new DescriptionTooltipBlock(spellItem.description).block);
         }
         return tooltip;
      }
   }
}
class paramClass extends Object
{
   
   function paramClass() {
      super();
   }
   
   public var contextual:Boolean = false;
   
   public var name:Boolean = true;
   
   public var header:Boolean = true;
   
   public var description:Boolean = true;
   
   public var effects:Boolean = true;
   
   public var noBg:Boolean = false;
   
   public var smallSpell:Boolean = false;
   
   public var CC_EC:Boolean = true;
   
   public var shortcutKey:String = "";
}
