package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.prism.PrismFightersInformation;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PrismFightAddedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PrismFightAddedMessage() {
         this.fight = new PrismFightersInformation();
         super();
      }
      
      public static const protocolId:uint = 6452;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var fight:PrismFightersInformation;
      
      override public function getMessageId() : uint {
         return 6452;
      }
      
      public function initPrismFightAddedMessage(fight:PrismFightersInformation = null) : PrismFightAddedMessage {
         this.fight = fight;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fight = new PrismFightersInformation();
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
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_PrismFightAddedMessage(output);
      }
      
      public function serializeAs_PrismFightAddedMessage(output:IDataOutput) : void {
         this.fight.serializeAs_PrismFightersInformation(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PrismFightAddedMessage(input);
      }
      
      public function deserializeAs_PrismFightAddedMessage(input:IDataInput) : void {
         this.fight = new PrismFightersInformation();
         this.fight.deserialize(input);
      }
   }
}
