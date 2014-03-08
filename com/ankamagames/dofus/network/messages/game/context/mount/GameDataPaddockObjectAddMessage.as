package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockItem;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameDataPaddockObjectAddMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameDataPaddockObjectAddMessage() {
         this.paddockItemDescription = new PaddockItem();
         super();
      }
      
      public static const protocolId:uint = 5990;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var paddockItemDescription:PaddockItem;
      
      override public function getMessageId() : uint {
         return 5990;
      }
      
      public function initGameDataPaddockObjectAddMessage(paddockItemDescription:PaddockItem=null) : GameDataPaddockObjectAddMessage {
         this.paddockItemDescription = paddockItemDescription;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.paddockItemDescription = new PaddockItem();
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
         this.serializeAs_GameDataPaddockObjectAddMessage(output);
      }
      
      public function serializeAs_GameDataPaddockObjectAddMessage(output:IDataOutput) : void {
         this.paddockItemDescription.serializeAs_PaddockItem(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameDataPaddockObjectAddMessage(input);
      }
      
      public function deserializeAs_GameDataPaddockObjectAddMessage(input:IDataInput) : void {
         this.paddockItemDescription = new PaddockItem();
         this.paddockItemDescription.deserialize(input);
      }
   }
}
