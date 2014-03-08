package com.ankamagames.dofus.logic.game.fight.managers
{
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMarkedCell;
   import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.atouin.renderers.TrapZoneRenderer;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.dofus.network.enums.GameActionMarkCellsTypeEnum;
   import com.ankamagames.jerakine.types.zones.Cross;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.jerakine.types.zones.Lozenge;
   import com.ankamagames.jerakine.types.zones.Custom;
   import com.ankamagames.atouin.managers.SelectionManager;
   import com.ankamagames.dofus.types.entities.Glyph;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class MarkedCellsManager extends Object implements IDestroyable
   {
      
      public function MarkedCellsManager() {
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
      
      public static function getInstance() : MarkedCellsManager {
         if(_self == null)
         {
            _self = new MarkedCellsManager();
         }
         return _self;
      }
      
      private var _marks:Dictionary;
      
      private var _glyphs:Dictionary;
      
      private var _markUid:uint;
      
      public function addMark(param1:int, param2:int, param3:Spell, param4:Vector.<GameActionMarkedCell>) : void {
         var _loc5_:MarkInstance = null;
         var _loc6_:GameActionMarkedCell = null;
         var _loc7_:Selection = null;
         var _loc8_:Vector.<uint> = null;
         var _loc9_:GameActionMarkedCell = null;
         var _loc10_:uint = 0;
         if(!this._marks[param1] || this._marks[param1].cells.length == 0)
         {
            _loc5_ = new MarkInstance();
            _loc5_.markId = param1;
            _loc5_.markType = param2;
            _loc5_.associatedSpell = param3;
            _loc5_.selections = new Vector.<Selection>(0,false);
            _loc5_.cells = new Vector.<uint>(0,false);
            if(param4.length > 0)
            {
               _loc6_ = param4[0];
               _loc7_ = new Selection();
               _loc7_.color = new Color(_loc6_.cellColor);
               _loc7_.renderer = new TrapZoneRenderer(PlacementStrataEnums.STRATA_GLYPH);
               _loc8_ = new Vector.<uint>();
               for each (_loc9_ in param4)
               {
                  _loc8_.push(_loc9_.cellId);
               }
               if(_loc6_.cellsType == GameActionMarkCellsTypeEnum.CELLS_CROSS)
               {
                  _loc7_.zone = new Cross(0,_loc6_.zoneSize,DataMapProvider.getInstance());
               }
               else
               {
                  if(_loc6_.zoneSize > 0)
                  {
                     _loc7_.zone = new Lozenge(0,_loc6_.zoneSize,DataMapProvider.getInstance());
                  }
                  else
                  {
                     _loc7_.zone = new Custom(_loc8_);
                  }
               }
               SelectionManager.getInstance().addSelection(_loc7_,this.getSelectionUid(),_loc6_.cellId);
               for each (_loc10_ in _loc7_.cells)
               {
                  _loc5_.cells.push(_loc10_);
               }
               _loc5_.selections.push(_loc7_);
            }
            this._marks[param1] = _loc5_;
            this.updateDataMapProvider();
         }
      }
      
      public function getMarkDatas(param1:int) : MarkInstance {
         return this._marks[param1];
      }
      
      public function removeMark(param1:int) : void {
         var _loc3_:Selection = null;
         var _loc2_:Vector.<Selection> = (this._marks[param1] as MarkInstance).selections;
         for each (_loc3_ in _loc2_)
         {
            _loc3_.remove();
         }
         delete this._marks[[param1]];
         this.updateDataMapProvider();
      }
      
      public function addGlyph(param1:Glyph, param2:int) : void {
         this._glyphs[param2] = param1;
      }
      
      public function getGlyph(param1:int) : Glyph {
         return this._glyphs[param1] as Glyph;
      }
      
      public function removeGlyph(param1:int) : void {
         if(this._glyphs[param1])
         {
            Glyph(this._glyphs[param1]).remove();
            delete this._glyphs[[param1]];
         }
      }
      
      public function destroy() : void {
         var _loc2_:String = null;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:String = null;
         var _loc1_:Array = new Array();
         for (_loc2_ in this._marks)
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
         for (_loc5_ in this._glyphs)
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
      
      private function getSelectionUid() : String {
         return MARK_SELECTIONS_PREFIX + this._markUid++;
      }
      
      private function updateDataMapProvider() : void {
         var _loc2_:MarkInstance = null;
         var _loc3_:DataMapProvider = null;
         var _loc4_:MapPoint = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc1_:Array = [];
         for each (_loc2_ in this._marks)
         {
            for each (_loc6_ in _loc2_.cells)
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
      }
   }
}
