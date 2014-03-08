package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.prism.PrismFightersInformation;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PrismsInfoValidMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PrismsInfoValidMessage() {
         this.fights = new Vector.<PrismFightersInformation>();
         super();
      }
      
      public static const protocolId:uint = 6451;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var fights:Vector.<PrismFightersInformation>;
      
      override public function getMessageId() : uint {
         return 6451;
      }
      
      public function initPrismsInfoValidMessage(param1:Vector.<PrismFightersInformation>=null) : PrismsInfoValidMessage {
         this.fights = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fights = new Vector.<PrismFightersInformation>();
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
         this.serializeAs_PrismsInfoValidMessage(param1);
      }
      
      public function serializeAs_PrismsInfoValidMessage(param1:IDataOutput) : void {
         param1.writeShort(this.fights.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.fights.length)
         {
            (this.fights[_loc2_] as PrismFightersInformation).serializeAs_PrismFightersInformation(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PrismsInfoValidMessage(param1);
      }
      
      public function deserializeAs_PrismsInfoValidMessage(param1:IDataInput) : void {
         var _loc4_:PrismFightersInformation = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new PrismFightersInformation();
            _loc4_.deserialize(param1);
            this.fights.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
