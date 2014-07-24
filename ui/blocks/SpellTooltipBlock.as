package blocks
{
   import d2hooks.*;
   import d2enums.SpellShapeEnum;
   
   public class SpellTooltipBlock extends Object
   {
      
      public function SpellTooltipBlock(spellItem:Object, param:Object = null) {
         super();
         this.sysApi = Api.system;
         this.uiApi = Api.ui;
         this.dataApi = Api.data;
         this.playerApi = Api.player;
         this._spellItem = spellItem;
         this._param = new paramClass();
         if(param)
         {
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
            if(param.hasOwnProperty("contextual"))
            {
               this._param.contextual = param.contextual;
            }
            if(param.hasOwnProperty("shortcutKey"))
            {
               this._param.shortcutKey = param.shortcutKey;
            }
            if(param.hasOwnProperty("effects"))
            {
               this._param.effects = param.effects;
            }
         }
         this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,this.getContent);
         this._block.initChunk([Api.tooltip.createChunkData("name","chunks/spell/name.txt"),Api.tooltip.createChunkData("apracost","chunks/spell/apracost.txt"),Api.tooltip.createChunkData("area","chunks/spell/area.txt"),Api.tooltip.createChunkData("simpleText","chunks/base/simpleText.txt"),Api.tooltip.createChunkData("simpleMultilineText","chunks/base/simpleMultilineText.txt")]);
      }
      
      public var playerApi:Object;
      
      public var sysApi:Object;
      
      public var uiApi:Object;
      
      public var dataApi:Object;
      
      private var _spellItem:Object;
      
      private var _content:String = "";
      
      private var _block:Object;
      
      private var _param:paramClass;
      
      private var _shortcutKey:String;
      
      public function onAllChunkLoaded() : void {
         var criticalRate:* = 0;
         var maxRange:* = 0;
         var range:String = null;
         var zoneEffect:Object = null;
         var ray:uint = 0;
         var i:Object = null;
         var uri:String = null;
         var areaText:String = null;
         var visible:* = false;
         var state:* = 0;
         var spellState:Object = null;
         if(this._param.contextual)
         {
            criticalRate = this._spellItem.playerCriticalRate;
         }
         else
         {
            criticalRate = this._spellItem.criticalHitProbability;
         }
         var showCriticalRate:Boolean = !(criticalRate == 0);
         if(criticalRate < 2)
         {
            criticalRate = 2;
         }
         if(this._param.name)
         {
            if(this._param.contextual)
            {
               maxRange = this._spellItem.maximalRangeWithBoosts;
            }
            else
            {
               maxRange = this._spellItem.maximalRange;
            }
            if(this._spellItem.minimalRange == maxRange)
            {
               range = String(maxRange);
            }
            else
            {
               range = this._spellItem.minimalRange + " - " + maxRange;
            }
            this._content = this._content + this._block.getChunk("apracost").processContent(
               {
                  "apCost":this._spellItem.apCost,
                  "range":range
               });
         }
         var text:String = "";
         if(this._param.CC_EC)
         {
            if(showCriticalRate)
            {
               text = text + (this.uiApi.getText("ui.common.short.CriticalHit") + this.uiApi.getText("ui.common.colon") + "1/" + criticalRate);
            }
            if(this._spellItem.playerCriticalFailureRate)
            {
               if(showCriticalRate)
               {
                  text = text + " - ";
               }
               text = text + (this.uiApi.getText("ui.common.short.CriticalFailure") + this.uiApi.getText("ui.common.colon") + "1/" + this._spellItem.playerCriticalFailureRate);
            }
            if((text) && (this._spellItem.criticalFailureEndsTurn))
            {
               text = text + (" (" + this.uiApi.getText("ui.spellInfo.endsTurnOnCriticalFailure") + ")");
            }
            if(text)
            {
               this._content = this._content + this._block.getChunk("simpleText").processContent({"text":text});
            }
         }
         if(this._param.effects)
         {
            zoneEffect = this._spellItem.spellZoneEffects[0];
            ray = zoneEffect.zoneSize;
            for each(i in this._spellItem.spellZoneEffects)
            {
               if((!(i.zoneShape == 0)) && (i.zoneSize < 63) && ((i.zoneSize > ray) || (i.zoneSize == ray) && (zoneEffect.zoneShape == SpellShapeEnum.P)))
               {
                  ray = i.zoneSize;
                  zoneEffect = i;
               }
            }
            visible = false;
            switch(zoneEffect.zoneShape)
            {
               case SpellShapeEnum.minus:
                  uri = this.sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|diagonal";
                  areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.diagonal",zoneEffect.zoneSize),"m",zoneEffect.zoneSize <= 1);
                  visible = true;
                  break;
               case SpellShapeEnum.A:
                  uri = this.sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|everyone";
                  areaText = this.uiApi.getText("ui.spellarea.everyone");
                  visible = true;
                  break;
               case SpellShapeEnum.C:
                  if(zoneEffect.zoneSize == 63)
                  {
                     uri = this.sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|everyone";
                     areaText = this.uiApi.getText("ui.spellarea.everyone");
                  }
                  else
                  {
                     uri = this.sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|circle";
                     areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.circle",zoneEffect.zoneSize),"m",zoneEffect.zoneSize <= 1);
                  }
                  visible = true;
                  break;
               case SpellShapeEnum.D:
                  uri = this.sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|checkerboard";
                  areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.chessboard",zoneEffect.zoneSize),"m",zoneEffect.zoneSize <= 1);
                  visible = true;
                  break;
               case SpellShapeEnum.L:
                  uri = this.sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|line";
                  areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.line",zoneEffect.zoneSize + 1),"m",zoneEffect.zoneSize <= 1);
                  visible = true;
                  break;
               case SpellShapeEnum.O:
                  uri = this.sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|ring";
                  areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.ring",zoneEffect.zoneSize),"m",zoneEffect.zoneSize <= 1);
                  visible = true;
                  break;
               case SpellShapeEnum.P:
                  break;
               case SpellShapeEnum.Q:
                  uri = this.sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|cross2";
                  areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.crossVoid",zoneEffect.zoneSize),"m",zoneEffect.zoneSize <= 1);
                  visible = true;
                  break;
               case SpellShapeEnum.T:
                  uri = this.sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|tarea";
                  areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.tarea",zoneEffect.zoneSize),"m",zoneEffect.zoneSize <= 1);
                  visible = true;
                  break;
               case SpellShapeEnum.U:
                  uri = this.sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|alfcircle";
                  areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.halfcircle",zoneEffect.zoneSize),"m",zoneEffect.zoneSize <= 1);
                  visible = true;
                  break;
               case SpellShapeEnum.V:
                  uri = this.sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|cone";
                  areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.cone",zoneEffect.zoneSize),"m",zoneEffect.zoneSize <= 1);
                  visible = true;
                  break;
               case SpellShapeEnum.X:
                  uri = this.sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|cross";
                  areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.cross",zoneEffect.zoneSize),"m",zoneEffect.zoneSize <= 1);
                  visible = true;
                  break;
               case SpellShapeEnum.G:
                  uri = this.sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|square";
                  areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.square",zoneEffect.zoneSize),"m",zoneEffect.zoneSize <= 1);
                  visible = true;
                  break;
            }
            if(visible)
            {
               this._content = this._content + this._block.getChunk("area").processContent(
                  {
                     "areaUri":uri,
                     "areaSize":areaText,
                     "visible":visible
                  });
            }
            if(!this._param.smallSpell)
            {
               this._content = this._content + this._block.getChunk("simpleText").processContent({"text":this.uiApi.getText("ui.common.rank",this._spellItem.spellLevel)});
            }
            if((this._spellItem.spellBreed) && (this._spellItem.spellBreed <= 12) && (!this._param.smallSpell))
            {
               this._content = this._content + this._block.getChunk("simpleText").processContent({"text":Api.ui.getText("ui.common.breedSpell") + Api.ui.getText("ui.common.colon") + this.dataApi.getBreed(this._spellItem.spellBreed).shortName});
            }
            if(this._spellItem.rangeCanBeBoosted)
            {
               this._content = this._content + this._block.getChunk("simpleMultilineText").processContent({"text":Api.ui.getText("ui.spell.rangeBoost")});
            }
            if((this._spellItem.castInLine) && (this._spellItem.range))
            {
               this._content = this._content + this._block.getChunk("simpleMultilineText").processContent({"text":this.uiApi.getText("ui.spellInfo.castInLine")});
            }
            if((this._spellItem.castInDiagonal) && (this._spellItem.range))
            {
               this._content = this._content + this._block.getChunk("simpleMultilineText").processContent({"text":this.uiApi.getText("ui.spellInfo.castInDiagonal")});
            }
            if((!this._spellItem.castTestLos) && (this._spellItem.range))
            {
               this._content = this._content + this._block.getChunk("simpleMultilineText").processContent({"text":this.uiApi.getText("ui.spellInfo.castWithoutLos")});
            }
            if(this._spellItem.needTakenCell)
            {
               this._content = this._content + this._block.getChunk("simpleMultilineText").processContent({"text":this.uiApi.getText("ui.spellInfo.castNeedTakenCell")});
            }
            if(this._spellItem.maxCastPerTarget)
            {
               this._content = this._content + this._block.getChunk("simpleMultilineText").processContent({"text":this.uiApi.getText("ui.spellInfo.maxCastPerTarget") + Api.ui.getText("ui.common.colon") + this._spellItem.maxCastPerTarget});
            }
            if(this._spellItem.maxStack > 0)
            {
               this._content = this._content + this._block.getChunk("simpleMultilineText").processContent({"text":this.uiApi.getText("ui.spellInfo.maxStack") + Api.ui.getText("ui.common.colon") + this._spellItem.maxStack});
            }
            if(this._spellItem.maxCastPerTurn)
            {
               this._content = this._content + this._block.getChunk("simpleMultilineText").processContent({"text":this.uiApi.getText("ui.spellInfo.maxCastPerTurn") + Api.ui.getText("ui.common.colon") + this._spellItem.maxCastPerTurn});
            }
            if(this._spellItem.minCastInterval)
            {
               this._content = this._content + this._block.getChunk("simpleMultilineText").processContent({"text":this.uiApi.getText("ui.spellInfo.minCastInterval") + Api.ui.getText("ui.common.colon") + this._spellItem.minCastInterval});
            }
            if(this._spellItem.globalCooldown)
            {
               if(this._spellItem.globalCooldown == -1)
               {
                  this._content = this._content + this._block.getChunk("simpleMultilineText").processContent({"text":this.uiApi.getText("ui.spellInfo.globalCastInterval")});
               }
               else
               {
                  this._content = this._content + this._block.getChunk("simpleMultilineText").processContent({"text":this.uiApi.getText("ui.spellInfo.globalCastInterval") + Api.ui.getText("ui.common.colon") + this._spellItem.globalCooldown});
               }
            }
            if(this._spellItem.statesRequired.length > 0)
            {
               for each(state in this._spellItem.statesRequired)
               {
                  spellState = this.dataApi.getSpellState(state);
                  this._content = this._content + this._block.getChunk("simpleMultilineText").processContent({"text":this.uiApi.getText("ui.spellInfo.stateRequired") + Api.ui.getText("ui.common.colon") + spellState.name});
               }
            }
            if(this._spellItem.statesForbidden.length > 0)
            {
               for each(state in this._spellItem.statesForbidden)
               {
                  spellState = this.dataApi.getSpellState(state);
                  this._content = this._content + this._block.getChunk("simpleMultilineText").processContent({"text":this.uiApi.getText("ui.spellInfo.stateForbidden") + Api.ui.getText("ui.common.colon") + spellState.name});
               }
            }
         }
      }
      
      public function getContent() : String {
         return this._content;
      }
      
      public function get block() : Object {
         return this._block;
      }
   }
}
class paramClass extends Object
{
   
   function paramClass() {
      super();
   }
   
   public var contextual:Boolean = false;
   
   public var smallSpell:Boolean = false;
   
   public var CC_EC:Boolean = true;
   
   public var name:Boolean = true;
   
   public var effects:Boolean = true;
   
   public var shortcutKey:String;
}
