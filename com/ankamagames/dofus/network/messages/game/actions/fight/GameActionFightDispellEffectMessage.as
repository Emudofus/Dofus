package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameActionFightDispellEffectMessage extends GameActionFightDispellMessage implements INetworkMessage
   {
      
      public function GameActionFightDispellEffectMessage() {
         super();
      }
      
      public static const protocolId:uint = 6113;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var boostUID:uint = 0;
      
      override public function getMessageId() : uint {
         return 6113;
      }
      
      public function initGameActionFightDispellEffectMessage(actionId:uint=0, sourceId:int=0, targetId:int=0, boostUID:uint=0) : GameActionFightDispellEffectMessage {
         super.initGameActionFightDispellMessage(actionId,sourceId,targetId);
         this.boostUID = boostUID;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.boostUID = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameActionFightDispellEffectMessage(output);
      }
      
      public function serializeAs_GameActionFightDispellEffectMessage(output:IDataOutput) : void {
         super.serializeAs_GameActionFightDispellMessage(output);
         if(this.boostUID < 0)
         {
            throw new Error("Forbidden value (" + this.boostUID + ") on element boostUID.");
         }
         else
         {
            output.writeInt(this.boostUID);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameActionFightDispellEffectMessage(input);
      }
      
      public function deserializeAs_GameActionFightDispellEffectMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.boostUID = input.readInt();
         if(this.boostUID < 0)
         {
            throw new Error("Forbidden value (" + this.boostUID + ") on element of GameActionFightDispellEffectMessage.boostUID.");
         }
         else
         {
            return;
         }
      }
   }
}
