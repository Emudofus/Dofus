package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockContentInformations;
   import __AS3__.vec.*;
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
      
      public function initGuildInformationsPaddocksMessage(nbPaddockMax:uint=0, paddocksInformations:Vector.<PaddockContentInformations>=null) : GuildInformationsPaddocksMessage {
         this.nbPaddockMax = nbPaddockMax;
         this.paddocksInformations = paddocksInformations;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.nbPaddockMax = 0;
         this.paddocksInformations = new Vector.<PaddockContentInformations>();
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
         this.serializeAs_GuildInformationsPaddocksMessage(output);
      }
      
      public function serializeAs_GuildInformationsPaddocksMessage(output:IDataOutput) : void {
         if(this.nbPaddockMax < 0)
         {
            throw new Error("Forbidden value (" + this.nbPaddockMax + ") on element nbPaddockMax.");
         }
         else
         {
            output.writeByte(this.nbPaddockMax);
            output.writeShort(this.paddocksInformations.length);
            _i2 = 0;
            while(_i2 < this.paddocksInformations.length)
            {
               (this.paddocksInformations[_i2] as PaddockContentInformations).serializeAs_PaddockContentInformations(output);
               _i2++;
            }
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildInformationsPaddocksMessage(input);
      }
      
      public function deserializeAs_GuildInformationsPaddocksMessage(input:IDataInput) : void {
         var _item2:PaddockContentInformations = null;
         this.nbPaddockMax = input.readByte();
         if(this.nbPaddockMax < 0)
         {
            throw new Error("Forbidden value (" + this.nbPaddockMax + ") on element of GuildInformationsPaddocksMessage.nbPaddockMax.");
         }
         else
         {
            _paddocksInformationsLen = input.readUnsignedShort();
            _i2 = 0;
            while(_i2 < _paddocksInformationsLen)
            {
               _item2 = new PaddockContentInformations();
               _item2.deserialize(input);
               this.paddocksInformations.push(_item2);
               _i2++;
            }
            return;
         }
      }
   }
}
