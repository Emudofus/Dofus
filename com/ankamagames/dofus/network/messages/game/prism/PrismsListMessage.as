package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.prism.PrismSubareaEmptyInfo;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class PrismsListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PrismsListMessage() {
         this.prisms = new Vector.<PrismSubareaEmptyInfo>();
         super();
      }
      
      public static const protocolId:uint = 6440;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var prisms:Vector.<PrismSubareaEmptyInfo>;
      
      override public function getMessageId() : uint {
         return 6440;
      }
      
      public function initPrismsListMessage(param1:Vector.<PrismSubareaEmptyInfo>=null) : PrismsListMessage {
         this.prisms = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.prisms = new Vector.<PrismSubareaEmptyInfo>();
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
         this.serializeAs_PrismsListMessage(param1);
      }
      
      public function serializeAs_PrismsListMessage(param1:IDataOutput) : void {
         param1.writeShort(this.prisms.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.prisms.length)
         {
            param1.writeShort((this.prisms[_loc2_] as PrismSubareaEmptyInfo).getTypeId());
            (this.prisms[_loc2_] as PrismSubareaEmptyInfo).serialize(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PrismsListMessage(param1);
      }
      
      public function deserializeAs_PrismsListMessage(param1:IDataInput) : void {
         var _loc4_:uint = 0;
         var _loc5_:PrismSubareaEmptyInfo = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readUnsignedShort();
            _loc5_ = ProtocolTypeManager.getInstance(PrismSubareaEmptyInfo,_loc4_);
            _loc5_.deserialize(param1);
            this.prisms.push(_loc5_);
            _loc3_++;
         }
      }
   }
}
