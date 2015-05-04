package com.ankamagames.dofus.logic.game.fight.managers
{
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMarkedCell;
   import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.dofus.network.enums.GameActionMarkTypeEnum;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.renderers.TrapZoneRenderer;
   import com.ankamagames.dofus.network.enums.GameActionMarkCellsTypeEnum;
   import com.ankamagames.jerakine.types.zones.Cross;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.jerakine.types.zones.Lozenge;
   import com.ankamagames.jerakine.types.zones.Custom;
   import com.ankamagames.atouin.managers.SelectionManager;
   import com.ankamagames.dofus.network.enums.TeamEnum;
   import com.ankamagames.dofus.types.entities.Glyph;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class MarkedCellsManager extends Object implements IDestroyable
   {
      
      public function MarkedCellsManager()
      {
         super();
         if(_self != null)
         {
            throw new SingletonError("MarkedCellsManager is a singleton and should not be instanciated directly.");
         }
         else
         {
            this._marks = new Dictionary(true);
            this._glyphs = new Dictionary(true);
            this._markUid = 0;
            return;
         }
      }
      
      private static const MARK_SELECTIONS_PREFIX:String = "FightMark";
      
      private static var _log:Logger = Log.getLogger(getQualifiedClassName(MarkedCellsManager));
      
      private static var _self:MarkedCellsManager;
      
      public static function getInstance() : MarkedCellsManager
      {
         if(_self == null)
         {
            _self = new MarkedCellsManager();
         }
         return _self;
      }
      
      private var _marks:Dictionary;
      
      private var _glyphs:Dictionary;
      
      private var _markUid:uint;
      
      public function addMark(param1:int, param2:int, param3:Spell, param4:SpellLevel, param5:Vector.<GameActionMarkedCell>, param6:int = 2, param7:Boolean = true, param8:int = -1) : void
      {
         var _loc9_:MarkInstance = null;
         var _loc10_:GameActionMarkedCell = null;
         var _loc11_:Selection = null;
         var _loc12_:uint = 0;
         var _loc13_:Vector.<uint> = null;
         var _loc14_:GameActionMarkedCell = null;
         var _loc15_:uint = 0;
         if(!this._marks[param1] || this._marks[param1].cells.length == 0)
         {
            _loc9_ = new MarkInstance();
            _loc9_.markId = param1;
            _loc9_.markType = param2;
            _loc9_.associatedSpell = param3;
            _loc9_.associatedSpellLevel = param4;
            _loc9_.selections = new Vector.<Selection>(0,false);
            _loc9_.cells = new Vector.<uint>(0,false);
            _loc9_.teamId = param6;
            _loc9_.active = param7;
            if(param8 != -1)
            {
               _loc9_.markImpactCellId = param8;
            }
            else if((param5) && (param5.length) && (param5[0]))
            {
               _loc9_.markImpactCellId = param5[0].cellId;
            }
            else
            {
               _log.warn("Adding a mark with unknown markImpactCellId!");
            }
            
            if(param5.length > 0)
            {
               _loc10_ = param5[0];
               _loc11_ = new Selection();
               _loc11_.color = new Color(_loc10_.cellColor);
               _loc12_ = param2 == GameActionMarkTypeEnum.PORTAL?PlacementStrataEnums.STRATA_PORTAL:PlacementStrataEnums.STRATA_GLYPH;
               _loc11_.renderer = new TrapZoneRenderer(_loc12_);
               _loc13_ = new Vector.<uint>();
               for each(_loc14_ in param5)
               {
                  _loc13_.push(_loc14_.cellId);
               }
               if(_loc10_.cellsType == GameActionMarkCellsTypeEnum.CELLS_CROSS)
               {
                  _loc11_.zone = new Cross(0,_loc10_.zoneSize,DataMapProvider.getInstance());
               }
               else if(_loc10_.zoneSize > 0)
               {
                  _loc11_.zone = new Lozenge(0,_loc10_.zoneSize,DataMapProvider.getInstance());
               }
               else
               {
                  _loc11_.zone = new Custom(_loc13_);
               }
               
               SelectionManager.getInstance().addSelection(_loc11_,this.getSelectionUid(),_loc10_.cellId);
               for each(_loc15_ in _loc11_.cells)
               {
                  _loc9_.cells.push(_loc15_);
               }
               _loc9_.selections.push(_loc11_);
            }
            this._marks[param1] = _loc9_;
            this.updateDataMapProvider();
         }
      }
      
      public function getMarks(param1:int, param2:int, param3:Boolean = true) : Vector.<MarkInstance>
      {
         var _loc5_:MarkInstance = null;
         var _loc4_:Vector.<MarkInstance> = new Vector.<MarkInstance>();
         for each(_loc5_ in this._marks)
         {
            if(_loc5_.markType == param1 && (param2 == TeamEnum.TEAM_SPECTATOR || _loc5_.teamId == param2) && (!param3 || (_loc5_.active)))
            {
               _loc4_.push(_loc5_);
            }
         }
         return _loc4_;
      }
      
      public function getMarkDatas(param1:int) : MarkInstance
      {
         return this._marks[param1];
      }
      
      public function removeMark(param1:int) : void
      {
         var _loc3_:Selection = null;
         var _loc2_:Vector.<Selection> = (this._marks[param1] as MarkInstance).selections;
         for each(_loc3_ in _loc2_)
         {
            _loc3_.remove();
         }
         delete this._marks[param1];
         true;
         this.updateDataMapProvider();
      }
      
      public function addGlyph(param1:Glyph, param2:int) : void
      {
         this._glyphs[param2] = param1;
      }
      
      public function getGlyph(param1:int) : Glyph
      {
         return this._glyphs[param1] as Glyph;
      }
      
      public function removeGlyph(param1:int) : void
      {
         if(this._glyphs[param1])
         {
            Glyph(this._glyphs[param1]).remove();
            delete this._glyphs[param1];
            true;
         }
      }
      
      public function getMarksMapPoint(param1:int, param2:int = 2, param3:Boolean = true) : Vector.<MapPoint>
      {
         var _loc5_:MarkInstance = null;
         var _loc4_:Vector.<MapPoint> = new Vector.<MapPoint>();
         for each(_loc5_ in this._marks)
         {
            if(_loc5_.markType == param1 && (param2 == TeamEnum.TEAM_SPECTATOR || _loc5_.teamId == param2) && (!param3 || (_loc5_.active)))
            {
               _loc4_.push(MapPoint.fromCellId(_loc5_.cells[0]));
            }
         }
         return _loc4_;
      }
      
      public function getMarkAtCellId(param1:uint, param2:int = -1) : MarkInstance
      {
         var _loc3_:MarkInstance = null;
         for each(_loc3_ in this._marks)
         {
            if(_loc3_.markImpactCellId == param1 && (param2 == -1 || param2 == _loc3_.markType))
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function cellHasTrap(param1:uint) : Boolean
      {
         var _loc2_:MarkInstance = null;
         for each(_loc2_ in this._marks)
         {
            if(_loc2_.markImpactCellId == param1 && _loc2_.markType == GameActionMarkTypeEnum.TRAP)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getCellIdsFromMarkIds(param1:Vector.<int>) : Vector.<int>
      {
         var _loc3_:* = 0;
         var _loc2_:Vector.<int> = new Vector.<int>();
         for each(_loc3_ in param1)
         {
            if((this._marks[_loc3_]) && (this._marks[_loc3_].cells) && this._marks[_loc3_].cells.length == 1)
            {
               _loc2_.push(this._marks[_loc3_].cells[0]);
            }
            else
            {
               _log.warn("Can\'t find cellId for markId " + _loc3_ + " in getCellIdsFromMarkIds()");
            }
         }
         _loc2_.fixed = true;
         return _loc2_;
      }
      
      public function getMapPointsFromMarkIds(param1:Vector.<int>) : Vector.<MapPoint>
      {
         var _loc3_:* = 0;
         var _loc2_:Vector.<MapPoint> = new Vector.<MapPoint>();
         for each(_loc3_ in param1)
         {
            if((this._marks[_loc3_]) && (this._marks[_loc3_].cells) && this._marks[_loc3_].cells.length == 1)
            {
               _loc2_.push(MapPoint.fromCellId(this._marks[_loc3_].cells[0]));
            }
            else
            {
               _log.warn("Can\'t find cellId for markId " + _loc3_ + " in getMapPointsFromMarkIds()");
            }
         }
         _loc2_.fixed = true;
         return _loc2_;
      }
      
      public function getActivePortalsCount(param1:int = 2) : uint
      {
         var _loc3_:MarkInstance = null;
         var _loc2_:uint = 0;
         for each(_loc3_ in this._marks)
         {
            if(_loc3_.markType == GameActionMarkTypeEnum.PORTAL && (param1 == TeamEnum.TEAM_SPECTATOR || _loc3_.teamId == param1) && (_loc3_.active))
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      public function destroy() : void
      {
         var _loc2_:String = null;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:String = null;
         var _loc1_:Array = new Array();
         for(_loc2_ in this._marks)
         {
            _loc1_.push(int(_loc2_));
         }
         _loc3_ = -1;
         _loc4_ = _loc1_.length;
         while(++_loc3_ < _loc4_)
         {
            this.removeMark(_loc1_[_loc3_]);
         }
         _loc1_.length = 0;
         for(_loc5_ in this._glyphs)
         {
            _loc1_.push(int(_loc5_));
         }
         _loc3_ = -1;
         _loc4_ = _loc1_.length;
         while(++_loc3_ < _loc4_)
         {
            this.removeGlyph(_loc1_[_loc3_]);
         }
         _self = null;
      }
      
      private function getSelectionUid() : String
      {
         return MARK_SELECTIONS_PREFIX + this._markUid++;
      }
      
      private function updateDataMapProvider() : void
      {
         var _loc2_:MarkInstance = null;
         var _loc3_:DataMapProvider = null;
         var _loc4_:MapPoint = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc1_:Array = [];
         for each(_loc2_ in this._marks)
         {
            for each(_loc6_ in _loc2_.cells)
            {
               _loc1_[_loc6_] = _loc1_[_loc6_] | _loc2_.markType;
            }
         }
         _loc3_ = DataMapProvider.getInstance();
         _loc5_ = 0;
         while(_loc5_ < AtouinConstants.MAP_CELLS_COUNT)
         {
            _loc4_ = MapPoint.fromCellId(_loc5_);
            _loc3_.setSpecialEffects(_loc5_,(_loc3_.pointSpecialEffects(_loc4_.x,_loc4_.y) | 3) ^ 3);
            if(_loc1_[_loc5_])
            {
               _loc3_.setSpecialEffects(_loc5_,_loc3_.pointSpecialEffects(_loc4_.x,_loc4_.y) | _loc1_[_loc5_]);
            }
            _loc5_++;
         }
         this.updateMarksNumber(GameActionMarkTypeEnum.PORTAL);
      }
      
      public function updateMarksNumber(param1:uint) : void
      {
         var _loc4_:MarkInstance = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:Color = null;
         var _loc8_:MarkInstance = null;
         var _loc2_:Array = new Array();
         var _loc3_:Array = new Array();
         for each(_loc4_ in this._marks)
         {
            if(_loc4_.markType == param1)
            {
               if(!_loc2_[_loc4_.teamId])
               {
                  _loc2_[_loc4_.teamId] = new Array();
                  _loc3_.push(_loc4_.teamId);
               }
               _loc2_[_loc4_.teamId].push(_loc4_);
            }
         }
         for each(_loc5_ in _loc3_)
         {
            _loc2_[_loc5_].sortOn("markId",Array.NUMERIC);
            _loc6_ = 1;
            for each(_loc8_ in _loc2_[_loc5_])
            {
               if(this._glyphs[_loc8_.markId])
               {
                  _loc7_ = _loc8_.selections[0].color;
                  Glyph(this._glyphs[_loc8_.markId]).addNumber(_loc6_,_loc7_);
               }
               _loc6_++;
            }
         }
      }
   }
}
