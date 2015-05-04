package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.version.VersionExtended;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   
   public class IdentificationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function IdentificationMessage()
      {
         this.version = new VersionExtended();
         this.credentials = new Vector.<int>();
         this.failedAttempts = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 4;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var version:VersionExtended;
      
      public var lang:String = "";
      
      public var credentials:Vector.<int>;
      
      public var serverId:int = 0;
      
      public var autoconnect:Boolean = false;
      
      public var useCertificate:Boolean = false;
      
      public var useLoginToken:Boolean = false;
      
      public var sessionOptionalSalt:Number = 0;
      
      public var failedAttempts:Vector.<uint>;
      
      override public function getMessageId() : uint
      {
         return 4;
      }
      
      public function initIdentificationMessage(param1:VersionExtended = null, param2:String = "", param3:Vector.<int> = null, param4:int = 0, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:Number = 0, param9:Vector.<uint> = null) : IdentificationMessage
      {
         this.version = param1;
         this.lang = param2;
         this.credentials = param3;
         this.serverId = param4;
         this.autoconnect = param5;
         this.useCertificate = param6;
         this.useLoginToken = param7;
         this.sessionOptionalSalt = param8;
         this.failedAttempts = param9;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.version = new VersionExtended();
         this.credentials = new Vector.<int>();
         this.serverId = 0;
         this.autoconnect = false;
         this.useCertificate = false;
         this.useLoginToken = false;
         this.sessionOptionalSalt = 0;
         this.failedAttempts = new Vector.<uint>();
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_IdentificationMessage(param1);
      }
      
      public function serializeAs_IdentificationMessage(param1:ICustomDataOutput) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,0,this.autoconnect);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,1,this.useCertificate);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,2,this.useLoginToken);
         param1.writeByte(_loc2_);
         this.version.serializeAs_VersionExtended(param1);
         param1.writeUTF(this.lang);
         param1.writeVarInt(this.credentials.length);
         var _loc3_:uint = 0;
         while(_loc3_ < this.credentials.length)
         {
            param1.writeByte(this.credentials[_loc3_]);
            _loc3_++;
         }
         param1.writeShort(this.serverId);
         if(this.sessionOptionalSalt < -9.007199254740992E15 || this.sessionOptionalSalt > 9.007199254740992E15)
         {
            throw new Error("Forbidden value (" + this.sessionOptionalSalt + ") on element sessionOptionalSalt.");
         }
         else
         {
            param1.writeDouble(this.sessionOptionalSalt);
            param1.writeShort(this.failedAttempts.length);
            var _loc4_:uint = 0;
            while(_loc4_ < this.failedAttempts.length)
            {
               if(this.failedAttempts[_loc4_] < 0)
               {
                  throw new Error("Forbidden value (" + this.failedAttempts[_loc4_] + ") on element 9 (starting at 1) of failedAttempts.");
               }
               else
               {
                  param1.writeVarShort(this.failedAttempts[_loc4_]);
                  _loc4_++;
                  continue;
               }
            }
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_IdentificationMessage(param1);
      }
      
      public function deserializeAs_IdentificationMessage(param1:ICustomDataInput) : void
      {
         var _loc7_:* = 0;
         var _loc8_:uint = 0;
         var _loc2_:uint = param1.readByte();
         this.autoconnect = BooleanByteWrapper.getFlag(_loc2_,0);
         this.useCertificate = BooleanByteWrapper.getFlag(_loc2_,1);
         this.useLoginToken = BooleanByteWrapper.getFlag(_loc2_,2);
         this.version = new VersionExtended();
         this.version.deserialize(param1);
         this.lang = param1.readUTF();
         var _loc3_:uint = param1.readVarInt();
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc7_ = param1.readByte();
            this.credentials.push(_loc7_);
            _loc4_++;
         }
         this.serverId = param1.readShort();
         this.sessionOptionalSalt = param1.readDouble();
         if(this.sessionOptionalSalt < -9.007199254740992E15 || this.sessionOptionalSalt > 9.007199254740992E15)
         {
            throw new Error("Forbidden value (" + this.sessionOptionalSalt + ") on element of IdentificationMessage.sessionOptionalSalt.");
         }
         else
         {
            var _loc5_:uint = param1.readUnsignedShort();
            var _loc6_:uint = 0;
            while(_loc6_ < _loc5_)
            {
               _loc8_ = param1.readVarUhShort();
               if(_loc8_ < 0)
               {
                  throw new Error("Forbidden value (" + _loc8_ + ") on elements of failedAttempts.");
               }
               else
               {
                  this.failedAttempts.push(_loc8_);
                  _loc6_++;
                  continue;
               }
            }
            return;
         }
      }
   }
}
