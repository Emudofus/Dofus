package com.ankamagames.dofus.network.messages.game.atlas
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.AtlasPointsInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AtlasPointInformationsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AtlasPointInformationsMessage() {
         this.type = new AtlasPointsInformations();
         super();
      }
      
      public static const protocolId:uint = 5956;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var type:AtlasPointsInformations;
      
      override public function getMessageId() : uint {
         return 5956;
      }
      
      public function initAtlasPointInformationsMessage(type:AtlasPointsInformations = null) : AtlasPointInformationsMessage {
         this.type = type;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.type = new AtlasPointsInformations();
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
         this.serializeAs_AtlasPointInformationsMessage(output);
      }
      
      public function serializeAs_AtlasPointInformationsMessage(output:IDataOutput) : void {
         this.type.serializeAs_AtlasPointsInformations(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AtlasPointInformationsMessage(input);
      }
      
      public function deserializeAs_AtlasPointInformationsMessage(input:IDataInput) : void {
         this.type = new AtlasPointsInformations();
         this.type.deserialize(input);
      }
   }
}
