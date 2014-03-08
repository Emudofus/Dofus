package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.debug.DebugHighlightCellsMessage;
   import com.ankamagames.dofus.network.messages.debug.DebugClearHighlightCellsMessage;
   import com.ankamagames.dofus.network.messages.debug.DebugInClientMessage;
   import com.ankamagames.atouin.managers.SelectionManager;
   import com.ankamagames.dofus.network.enums.DebugLevelEnum;
   import __AS3__.vec.Vector;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.atouin.renderers.ZoneDARenderer;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.types.zones.Custom;
   
   public class DebugFrame extends Object implements Frame
   {
      
      public function DebugFrame() {
         this._aZones = new Array();
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DebugFrame));
      
      private var _sName:String;
      
      private var _aZones:Array;
      
      public function get priority() : int {
         return 0;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:DebugHighlightCellsMessage = null;
         var _loc3_:DebugClearHighlightCellsMessage = null;
         var _loc4_:DebugInClientMessage = null;
         var _loc5_:String = null;
         switch(true)
         {
            case param1 is DebugHighlightCellsMessage:
               _loc2_ = param1 as DebugHighlightCellsMessage;
               this._sName = "debug_zone" + _loc2_.color + "_" + Math.round(Math.random() * 10000);
               this.displayZone(this._sName,_loc2_.cells,_loc2_.color);
               this._aZones.push(this._sName);
               return true;
            case param1 is DebugClearHighlightCellsMessage:
               _loc3_ = param1 as DebugClearHighlightCellsMessage;
               for each (_loc5_ in this._aZones)
               {
                  SelectionManager.getInstance().getSelection(_loc5_).remove();
               }
               return true;
            case param1 is DebugInClientMessage:
               _loc4_ = param1 as DebugInClientMessage;
               switch(_loc4_.level)
               {
                  case DebugLevelEnum.LEVEL_DEBUG:
                     _log.debug(_loc4_.message);
                     break;
                  case DebugLevelEnum.LEVEL_ERROR:
                     _log.error(_loc4_.message);
                     break;
                  case DebugLevelEnum.LEVEL_FATAL:
                     _log.fatal(_loc4_.message);
                     break;
                  case DebugLevelEnum.LEVEL_INFO:
                     _log.info(_loc4_.message);
                     break;
                  case DebugLevelEnum.LEVEL_TRACE:
                     _log.trace(_loc4_.message);
                     break;
                  case DebugLevelEnum.LEVEL_WARN:
                     _log.warn(_loc4_.message);
                     break;
               }
               return true;
            default:
               return false;
         }
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function pulled() : Boolean {
         return true;
      }
      
      private function displayZone(param1:String, param2:Vector.<uint>, param3:uint) : void {
         var _loc4_:Selection = new Selection();
         _loc4_.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_MOVEMENT);
         _loc4_.color = new Color(param3);
         _loc4_.zone = new Custom(param2);
         SelectionManager.getInstance().addSelection(_loc4_,param1);
         SelectionManager.getInstance().update(param1);
      }
   }
}
