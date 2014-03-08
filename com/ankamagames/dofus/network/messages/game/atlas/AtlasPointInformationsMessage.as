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
      
      public function initAtlasPointInformationsMessage(param1:AtlasPointsInformations=null) : AtlasPointInformationsMessage {
         this.type = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.type = new AtlasPointsInformations();
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_AtlasPointInformationsMessage(param1);
      }
      
      public function serializeAs_AtlasPointInformationsMessage(param1:IDataOutput) : void {
         this.type.serializeAs_AtlasPointsInformations(param1);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AtlasPointInformationsMessage(param1);
      }
      
      public function deserializeAs_AtlasPointInformationsMessage(param1:IDataInput) : void {
         this.type = new AtlasPointsInformations();
         this.type.deserialize(param1);
      }
   }
}
