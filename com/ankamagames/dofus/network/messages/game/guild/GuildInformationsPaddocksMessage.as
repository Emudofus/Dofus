package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockContentInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildInformationsPaddocksMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildInformationsPaddocksMessage() {
         this.paddocksInformations = new Vector.<PaddockContentInformations>();
         super();
      }
      
      public static const protocolId:uint = 5959;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var nbPaddockMax:uint = 0;
      
      public var paddocksInformations:Vector.<PaddockContentInformations>;
      
      override public function getMessageId() : uint {
         return 5959;
      }
      
      public function initGuildInformationsPaddocksMessage(param1:uint=0, param2:Vector.<PaddockContentInformations>=null) : GuildInformationsPaddocksMessage {
         this.nbPaddockMax = param1;
         this.paddocksInformations = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.nbPaddockMax = 0;
         this.paddocksInformations = new Vector.<PaddockContentInformations>();
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
         this.serializeAs_GuildInformationsPaddocksMessage(param1);
      }
      
      public function serializeAs_GuildInformationsPaddocksMessage(param1:IDataOutput) : void {
         if(this.nbPaddockMax < 0)
         {
            throw new Error("Forbidden value (" + this.nbPaddockMax + ") on element nbPaddockMax.");
         }
         else
         {
            param1.writeByte(this.nbPaddockMax);
            param1.writeShort(this.paddocksInformations.length);
            _loc2_ = 0;
            while(_loc2_ < this.paddocksInformations.length)
            {
               (this.paddocksInformations[_loc2_] as PaddockContentInformations).serializeAs_PaddockContentInformations(param1);
               _loc2_++;
            }
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildInformationsPaddocksMessage(param1);
      }
      
      public function deserializeAs_GuildInformationsPaddocksMessage(param1:IDataInput) : void {
         var _loc4_:PaddockContentInformations = null;
         this.nbPaddockMax = param1.readByte();
         if(this.nbPaddockMax < 0)
         {
            throw new Error("Forbidden value (" + this.nbPaddockMax + ") on element of GuildInformationsPaddocksMessage.nbPaddockMax.");
         }
         else
         {
            _loc2_ = param1.readUnsignedShort();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = new PaddockContentInformations();
               _loc4_.deserialize(param1);
               this.paddocksInformations.push(_loc4_);
               _loc3_++;
            }
            return;
         }
      }
   }
}
