package com.ankamagames.dofus.logic.game.fight.managers
{
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.types.entities.Glyph;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.types.zones.Custom;
   import com.ankamagames.atouin.renderers.CellLinkRenderer;
   import com.ankamagames.atouin.managers.SelectionManager;
   import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
   import com.ankamagames.dofus.network.enums.GameActionMarkTypeEnum;
   import com.ankamagames.dofus.types.enums.PortalAnimationEnum;
   import com.ankamagames.atouin.AtouinConstants;
   import flash.geom.Point;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class LinkedCellsManager extends Object implements IDestroyable
   {
      
      public function LinkedCellsManager()
      {
         super();
         if(_self != null)
         {
            throw new SingletonError("LinkedCellsManager is a singleton and should not be instanciated directly.");
         }
         else
         {
            this._selections = new Dictionary(true);
            return;
         }
      }
      
      private static var _log:Logger = Log.getLogger(getQualifiedClassName(LinkedCellsManager));
      
      private static var _self:LinkedCellsManager;
      
      public static function getInstance() : LinkedCellsManager
      {
         if(_self == null)
         {
            _self = new LinkedCellsManager();
         }
         return _self;
      }
      
      private static const SAME:int = 0;
      
      private static const OPPOSITE:int = 1;
      
      private static const TRIGONOMETRIC:int = 2;
      
      private static const COUNTER_TRIGONOMETRIC:int = 3;
      
      private var _selections:Dictionary;
      
      private var _portalExitGlyph:Glyph;
      
      public function getLinks(param1:MapPoint, param2:Vector.<MapPoint>) : Vector.<uint>
      {
         var _loc7_:MapPoint = null;
         var _loc8_:* = 0;
         if(!param2 || !param2.length || param2.length == 1 && param1.cellId == param2[0].cellId)
         {
            return new <uint>[param1.cellId];
         }
         var _loc3_:Vector.<MapPoint> = new Vector.<MapPoint>();
         var _loc4_:* = 0;
         while(_loc4_ < param2.length)
         {
            if(param2[_loc4_].cellId != param1.cellId)
            {
               _loc3_.push(param2[_loc4_]);
            }
            _loc4_++;
         }
         var _loc5_:Vector.<uint> = new Vector.<uint>();
         var _loc6_:MapPoint = param1;
         var _loc9_:uint = _loc3_.length + 1;
         while((_loc3_.length) || _loc9_ > 0)
         {
            _loc9_--;
            _loc5_.push(_loc6_.cellId);
            _loc8_ = _loc3_.indexOf(_loc6_);
            if(_loc8_ != -1)
            {
               _loc3_.splice(_loc8_,1);
            }
            _loc7_ = this.getClosestPortal(_loc6_,_loc3_);
            if(_loc7_ == null)
            {
               break;
            }
            _loc6_ = _loc7_;
         }
         if(_loc5_.length < 2)
         {
            return new <uint>[param1.cellId];
         }
         return _loc5_;
      }
      
      public function drawLinks(param1:String, param2:Vector.<uint>, param3:Number, param4:uint, param5:Number) : void
      {
         var _loc6_:Selection = null;
         if((param2) && param2.length > 1)
         {
            _loc6_ = new Selection();
            _loc6_.cells = param2;
            _loc6_.color = new Color(param4);
            _loc6_.zone = new Custom(param2);
            _loc6_.renderer = new CellLinkRenderer(param3,param5);
            SelectionManager.getInstance().addSelection(_loc6_,param1,param2[0]);
            this._selections[param1] = _loc6_;
         }
         else
         {
            _log.error("Not enough cells to draw links between them...");
         }
      }
      
      public function drawPortalLinks(param1:Vector.<uint>) : void
      {
         var _loc2_:* = 0;
         var _loc3_:Selection = null;
         var _loc4_:MarkInstance = null;
         if((param1) && (param1.length))
         {
            if(this._selections["eliaPortals"])
            {
               this.clearLinks("eliaPortals");
            }
            _loc2_ = param1[param1.length - 1];
            _loc3_ = new Selection();
            _loc3_.cells = param1;
            _loc3_.color = new Color(251623);
            _loc3_.zone = new Custom(param1);
            _loc3_.renderer = new CellLinkRenderer(10,0.5,true);
            SelectionManager.getInstance().addSelection(_loc3_,"eliaPortals",param1[0]);
            this._selections["eliaPortals"] = _loc3_;
            _loc4_ = MarkedCellsManager.getInstance().getMarkAtCellId(_loc2_,GameActionMarkTypeEnum.PORTAL);
            if(!_loc4_)
            {
               return;
            }
            this._portalExitGlyph = MarkedCellsManager.getInstance().getGlyph(_loc4_.markId);
            if(!this._portalExitGlyph)
            {
               return;
            }
            this._portalExitGlyph.setAnimation(PortalAnimationEnum.STATE_EXIT);
         }
         else
         {
            _log.error("Not enough cells to draw links between them...");
         }
      }
      
      public function clearLinks(param1:String = "") : void
      {
         var _loc3_:Selection = null;
         var _loc2_:* = false;
         if(!param1)
         {
            for(var param1 in this._selections)
            {
               _loc2_ = true;
               this._selections[param1].remove();
               delete this._selections[param1];
               true;
            }
         }
         else
         {
            _loc3_ = SelectionManager.getInstance().getSelection(param1);
            if(_loc3_)
            {
               _loc2_ = true;
               _loc3_.remove();
            }
            if(this._selections[param1])
            {
               delete this._selections[param1];
               true;
            }
         }
         if((_loc2_) && (this._portalExitGlyph))
         {
            if(this._portalExitGlyph.getAnimation() != PortalAnimationEnum.STATE_DISABLED)
            {
               this._portalExitGlyph.setAnimation(PortalAnimationEnum.STATE_NORMAL);
            }
         }
      }
      
      public function destroy() : void
      {
         if(_self)
         {
            this.clearLinks();
            this._selections = null;
            _self = null;
            this._portalExitGlyph = null;
         }
      }
      
      private function getClosestPortal(param1:MapPoint, param2:Vector.<MapPoint>) : MapPoint
      {
         var _loc5_:MapPoint = null;
         var _loc6_:* = 0;
         var _loc3_:Vector.<MapPoint> = new Vector.<MapPoint>();
         var _loc4_:int = AtouinConstants.PSEUDO_INFINITE;
         for each(_loc5_ in param2)
         {
            _loc6_ = param1.distanceToCell(_loc5_);
            if(_loc6_ < _loc4_)
            {
               _loc3_.length = 0;
               _loc3_.push(_loc5_);
               _loc4_ = _loc6_;
            }
            else if(_loc6_ == _loc4_)
            {
               _loc3_.push(_loc5_);
            }
            
         }
         if(!_loc3_.length)
         {
            return null;
         }
         if(_loc3_.length == 1)
         {
            return _loc3_[0];
         }
         return this.getBestNextPortal(param1,_loc3_);
      }
      
      private function getBestNextPortal(param1:MapPoint, param2:Vector.<MapPoint>) : MapPoint
      {
         var refCoord:Point = null;
         var nudge:Point = null;
         var refCell:MapPoint = param1;
         var closests:Vector.<MapPoint> = param2;
         if(closests.length < 2)
         {
            throw new ArgumentError("closests should have a size of 2.");
         }
         else
         {
            refCoord = refCell.coordinates;
            nudge = new Point(refCoord.x,refCoord.y + 1);
            closests.sort(function(param1:MapPoint, param2:MapPoint):int
            {
               var _loc3_:Number = getPositiveOrientedAngle(refCoord,nudge,new Point(param1.x,param1.y)) - getPositiveOrientedAngle(refCoord,nudge,new Point(param2.x,param2.y));
               return _loc3_ > 0?1:_loc3_ < 0?-1:0;
            });
            var res:MapPoint = this.getBestPortalWhenRefIsNotInsideClosests(refCell,closests);
            if(res != null)
            {
               return res;
            }
            return closests[0];
         }
      }
      
      private function getBestPortalWhenRefIsNotInsideClosests(param1:MapPoint, param2:Vector.<MapPoint>) : MapPoint
      {
         var _loc4_:MapPoint = null;
         if(param2.length < 2)
         {
            return null;
         }
         var _loc3_:MapPoint = param2[param2.length - 1];
         for each(_loc4_ in param2)
         {
            switch(this.compareAngles(param1.coordinates,_loc3_.coordinates,_loc4_.coordinates))
            {
               case OPPOSITE:
                  if(param2.length <= 2)
                  {
                     return null;
                  }
               case COUNTER_TRIGONOMETRIC:
                  return _loc3_;
               default:
                  _loc3_ = _loc4_;
                  continue;
            }
         }
         return null;
      }
      
      private function getPositiveOrientedAngle(param1:Point, param2:Point, param3:Point) : Number
      {
         switch(this.compareAngles(param1,param2,param3))
         {
            case SAME:
               return 0;
            case OPPOSITE:
               return Math.PI;
            case TRIGONOMETRIC:
               return this.getAngle(param1,param2,param3);
            case COUNTER_TRIGONOMETRIC:
               return 2 * Math.PI - this.getAngle(param1,param2,param3);
            default:
               return 0;
         }
      }
      
      private function compareAngles(param1:Point, param2:Point, param3:Point) : int
      {
         var _loc4_:Point = this.vector(param1,param2);
         var _loc5_:Point = this.vector(param1,param3);
         var _loc6_:int = this.getDeterminant(_loc4_,_loc5_);
         if(_loc6_ != 0)
         {
            return _loc6_ > 0?TRIGONOMETRIC:COUNTER_TRIGONOMETRIC;
         }
         return _loc4_.x >= 0 == _loc5_.x >= 0 && _loc4_.y >= 0 == _loc5_.y >= 0?SAME:OPPOSITE;
      }
      
      private function getAngle(param1:Point, param2:Point, param3:Point) : Number
      {
         var _loc4_:Number = this.getComplexDistance(param2,param3);
         var _loc5_:Number = this.getComplexDistance(param1,param2);
         var _loc6_:Number = this.getComplexDistance(param1,param3);
         return Math.acos((_loc5_ * _loc5_ + _loc6_ * _loc6_ - _loc4_ * _loc4_) / (2 * _loc5_ * _loc6_));
      }
      
      private function getComplexDistance(param1:Point, param2:Point) : Number
      {
         return Math.sqrt(Math.pow(param1.x - param2.x,2) + Math.pow(param1.y - param2.y,2));
      }
      
      private function getDeterminant(param1:Point, param2:Point) : int
      {
         return param1.x * param2.y - param1.y * param2.x;
      }
      
      private function vector(param1:Point, param2:Point) : Point
      {
         return new Point(param2.x - param1.x,param2.y - param1.y);
      }
   }
}
