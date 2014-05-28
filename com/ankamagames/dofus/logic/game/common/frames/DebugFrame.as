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
      
      protected static const _log:Logger;
      
      private var _sName:String;
      
      private var _aZones:Array;
      
      public function get priority() : int {
         return 0;
      }
      
      public function process(msg:Message) : Boolean {
         var dhcmsg:DebugHighlightCellsMessage = null;
         var dchcmsg:DebugClearHighlightCellsMessage = null;
         var dicmsg:DebugInClientMessage = null;
         var s:String = null;
         switch(true)
         {
            case msg is DebugHighlightCellsMessage:
               dhcmsg = msg as DebugHighlightCellsMessage;
               this._sName = "debug_zone" + dhcmsg.color + "_" + Math.round(Math.random() * 10000);
               this.displayZone(this._sName,dhcmsg.cells,dhcmsg.color);
               this._aZones.push(this._sName);
               return true;
            case msg is DebugClearHighlightCellsMessage:
               dchcmsg = msg as DebugClearHighlightCellsMessage;
               for each(s in this._aZones)
               {
                  SelectionManager.getInstance().getSelection(s).remove();
               }
               return true;
            case msg is DebugInClientMessage:
               dicmsg = msg as DebugInClientMessage;
               switch(dicmsg.level)
               {
                  case DebugLevelEnum.LEVEL_DEBUG:
                     _log.debug(dicmsg.message);
                     break;
                  case DebugLevelEnum.LEVEL_ERROR:
                     _log.error(dicmsg.message);
                     break;
                  case DebugLevelEnum.LEVEL_FATAL:
                     _log.fatal(dicmsg.message);
                     break;
                  case DebugLevelEnum.LEVEL_INFO:
                     _log.info(dicmsg.message);
                     break;
                  case DebugLevelEnum.LEVEL_TRACE:
                     _log.trace(dicmsg.message);
                     break;
                  case DebugLevelEnum.LEVEL_WARN:
                     _log.warn(dicmsg.message);
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
      
      private function displayZone(name:String, cells:Vector.<uint>, color:uint) : void {
         var s:Selection = new Selection();
         s.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_MOVEMENT);
         s.color = new Color(color);
         s.zone = new Custom(cells);
         SelectionManager.getInstance().addSelection(s,name);
         SelectionManager.getInstance().update(name);
      }
   }
}
