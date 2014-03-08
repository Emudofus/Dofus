package com.ankamagames.dofus.logic.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.network.messages.ServerConnectionFailedMessage;
   import com.ankamagames.dofus.network.messages.game.basic.BasicAckMessage;
   import com.ankamagames.dofus.network.messages.game.basic.BasicNoOperationMessage;
   import com.ankamagames.dofus.network.messages.connection.CredentialsAcknowledgementMessage;
   import com.ankamagames.dofus.network.messages.game.initialization.OnConnectionEventMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseBuyResultMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectJobAddedMessage;
   import com.ankamagames.berilia.types.messages.AllUiXmlParsedMessage;
   import com.ankamagames.jerakine.messages.ConnectionResumedMessage;
   import com.ankamagames.dofus.logic.connection.messages.GameStartingMessage;
   import com.ankamagames.dofus.logic.game.fight.actions.BannerEmptySlotClickAction;
   import com.ankamagames.atouin.messages.MapRenderProgressMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameEntitiesDispositionMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightShowFighterMessage;
   import com.ankamagames.berilia.components.messages.TextureReadyMessage;
   import com.ankamagames.berilia.components.messages.EntityReadyMessage;
   import com.ankamagames.berilia.components.messages.MapRollOverMessage;
   import com.ankamagames.berilia.components.messages.ChangeMessage;
   import com.ankamagames.berilia.components.messages.SelectItemMessage;
   import com.ankamagames.berilia.components.messages.MapMoveMessage;
   import com.ankamagames.berilia.components.messages.TextClickMessage;
   import com.ankamagames.berilia.components.messages.DropMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseMiddleClickMessage;
   import com.ankamagames.atouin.messages.MapsLoadingStartedMessage;
   import com.ankamagames.atouin.messages.EntityMovementStartMessage;
   import com.ankamagames.atouin.messages.MapContainerRollOverMessage;
   import com.ankamagames.atouin.messages.MapContainerRollOutMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextDestroyMessage;
   import com.ankamagames.dofus.network.messages.game.character.status.PlayerStatusUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import com.ankamagames.atouin.messages.AdjacentMapClickMessage;
   import com.ankamagames.atouin.messages.AdjacentMapOutMessage;
   import com.ankamagames.atouin.messages.AdjacentMapOverMessage;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOverMessage;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementActivationMessage;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementMouseOverMessage;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementMouseOutMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOverMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOutMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseUpMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDoubleClickMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyDownMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyUpMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickOutsideMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseReleaseOutsideMessage;
   import com.ankamagames.berilia.components.messages.ItemRollOverMessage;
   import com.ankamagames.berilia.components.messages.ItemRollOutMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
   import com.ankamagames.atouin.messages.CellOverMessage;
   import com.ankamagames.atouin.messages.CellOutMessage;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOutMessage;
   import com.ankamagames.dofus.logic.game.common.actions.PlaySoundAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShowMonstersInfoAction;
   import com.ankamagames.dofus.network.messages.game.context.fight.SlaveSwitchContextMessage;
   
   public class CleanupCrewFrame extends Object implements Frame
   {
      
      public function CleanupCrewFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CleanupCrewFrame));
      
      public function get priority() : int {
         return Priority.LOWEST;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         switch(true)
         {
            case param1 is ServerConnectionFailedMessage:
            case param1 is BasicAckMessage:
            case param1 is BasicNoOperationMessage:
            case param1 is CredentialsAcknowledgementMessage:
            case param1 is OnConnectionEventMessage:
            case param1 is ExchangeBidHouseBuyResultMessage:
            case param1 is ObjectJobAddedMessage:
            case param1 is AllUiXmlParsedMessage:
            case param1 is ConnectionResumedMessage:
            case param1 is GameStartingMessage:
            case param1 is BannerEmptySlotClickAction:
            case param1 is MapRenderProgressMessage:
            case param1 is GameEntitiesDispositionMessage:
            case param1 is GameFightShowFighterMessage:
            case param1 is TextureReadyMessage:
            case param1 is EntityReadyMessage:
            case param1 is MapRollOverMessage:
            case param1 is ChangeMessage:
            case param1 is SelectItemMessage:
            case param1 is MapMoveMessage:
            case param1 is TextClickMessage:
            case param1 is DropMessage:
            case param1 is MouseMiddleClickMessage:
            case param1 is MapsLoadingStartedMessage:
            case param1 is EntityMovementStartMessage:
            case param1 is MapContainerRollOverMessage:
            case param1 is MapContainerRollOutMessage:
            case param1 is GameContextDestroyMessage:
            case param1 is PlayerStatusUpdateMessage:
            case param1 is MapComplementaryInformationsDataMessage:
            case param1 is CellClickMessage:
            case param1 is AdjacentMapClickMessage:
            case param1 is AdjacentMapOutMessage:
            case param1 is AdjacentMapOverMessage:
            case param1 is EntityMouseOverMessage:
            case param1 is InteractiveElementActivationMessage:
            case param1 is InteractiveElementMouseOverMessage:
            case param1 is InteractiveElementMouseOutMessage:
            case param1 is MouseOverMessage:
            case param1 is MouseOutMessage:
            case param1 is MouseDownMessage:
            case param1 is MouseUpMessage:
            case param1 is MouseClickMessage:
            case param1 is MouseDoubleClickMessage:
            case param1 is KeyboardKeyDownMessage:
            case param1 is KeyboardKeyUpMessage:
            case param1 is MouseRightClickOutsideMessage:
            case param1 is MouseRightClickMessage:
            case param1 is MouseReleaseOutsideMessage:
            case param1 is ItemRollOverMessage:
            case param1 is ItemRollOutMessage:
            case param1 is MouseWheelMessage:
            case param1 is CellOverMessage:
            case param1 is CellOutMessage:
            case param1 is EntityMouseOutMessage:
            case param1 is PlaySoundAction:
            case param1 is ShowMonstersInfoAction:
            case param1 is SlaveSwitchContextMessage:
               return true;
            default:
               _log.warn("[Warning] " + (getQualifiedClassName(param1) as String).split("::")[1] + " wasn\'t stopped by a frame.");
               return true;
         }
      }
      
      public function pulled() : Boolean {
         return true;
      }
   }
}
