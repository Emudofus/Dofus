package com.ankamagames.dofus.internalDatacenter.taxi
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import flash.utils.Dictionary;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.datacenter.world.Hint;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.datacenter.world.Area;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   
   public class TeleportDestinationWrapper extends Object implements IDataCenter
   {
      
      public function TeleportDestinationWrapper(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:Boolean=false, param7:Hint=null) {
         var _loc9_:Area = null;
         super();
         this.teleporterType = param1;
         this.mapId = param2;
         this.subArea = SubArea.getSubAreaById(param3);
         this.destinationType = param4;
         this.cost = param5;
         this.spawn = param6;
         if(this.teleporterType == 1)
         {
            if(param7)
            {
               this.category = param7.categoryId;
               this.name = param7.name;
               this.nameId = param7.nameId;
            }
            else
            {
               this.category = -1;
            }
         }
         else
         {
            _loc9_ = Area.getAreaById(this.subArea.areaId);
            this.name = _loc9_.name + " (" + this.subArea.name + ")";
            this.nameId = _loc9_.nameId;
            this.subAreaNameId = this.subArea.nameId;
         }
         var _loc8_:Object = new WorldPointWrapper(param2);
         this.coord = _loc8_.outdoorX + "," + _loc8_.outdoorY;
      }
      
      private static var _hints:Dictionary;
      
      private static var _hintsRealMap:Dictionary;
      
      public static function getHintsFromMapId(param1:uint) : Vector.<Hint> {
         var _loc2_:Vector.<Hint> = null;
         generateHintsDictionary();
         if(_hintsRealMap.hasOwnProperty(param1))
         {
            _loc2_ = _hintsRealMap[param1];
         }
         else
         {
            _loc2_ = new Vector.<Hint>();
         }
         if(_hints.hasOwnProperty(param1))
         {
            return _loc2_.concat(_hints[param1]);
         }
         return _loc2_;
      }
      
      private static function generateHintsDictionary() : void {
         var _loc1_:Array = null;
         var _loc2_:Hint = null;
         if(!_hints)
         {
            _loc1_ = Hint.getHints();
            _hints = new Dictionary();
            _hintsRealMap = new Dictionary();
            for each (_loc2_ in _loc1_)
            {
               if(_hints.hasOwnProperty(_loc2_.mapId))
               {
                  _hints[_loc2_.mapId].push(_loc2_);
               }
               else
               {
                  _hints[_loc2_.mapId] = new Vector.<Hint>();
                  _hints[_loc2_.mapId].push(_loc2_);
               }
               if(_hintsRealMap.hasOwnProperty(_loc2_.realMapId))
               {
                  _hintsRealMap[_loc2_.realMapId].push(_loc2_);
               }
               else
               {
                  _hintsRealMap[_loc2_.realMapId] = new Vector.<Hint>();
                  _hintsRealMap[_loc2_.realMapId].push(_loc2_);
               }
            }
         }
      }
      
      public var teleporterType:uint;
      
      public var mapId:uint;
      
      public var subArea:SubArea;
      
      public var destinationType:uint;
      
      public var cost:uint;
      
      public var spawn:Boolean;
      
      public var subAreaNameId:uint;
      
      public var nameId:uint;
      
      public var name:String;
      
      public var hintName:String;
      
      public var coord:String;
      
      public var hintMapId:uint;
      
      public var category:int;
   }
}
