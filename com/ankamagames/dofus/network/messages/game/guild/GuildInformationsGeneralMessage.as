package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   
   public class GuildInformationsGeneralMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildInformationsGeneralMessage() {
         super();
      }
      
      public static const protocolId:uint = 5557;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var enabled:Boolean = false;
      
      public var abandonnedPaddock:Boolean = false;
      
      public var level:uint = 0;
      
      public var expLevelFloor:Number = 0;
      
      public var experience:Number = 0;
      
      public var expNextLevelFloor:Number = 0;
      
      public var creationDate:uint = 0;
      
      override public function getMessageId() : uint {
         return 5557;
      }
      
      public function initGuildInformationsGeneralMessage(param1:Boolean=false, param2:Boolean=false, param3:uint=0, param4:Number=0, param5:Number=0, param6:Number=0, param7:uint=0) : GuildInformationsGeneralMessage {
         this.enabled = param1;
         this.abandonnedPaddock = param2;
         this.level = param3;
         this.expLevelFloor = param4;
         this.experience = param5;
         this.expNextLevelFloor = param6;
         this.creationDate = param7;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.enabled = false;
         this.abandonnedPaddock = false;
         this.level = 0;
         this.expLevelFloor = 0;
         this.experience = 0;
         this.expNextLevelFloor = 0;
         this.creationDate = 0;
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
         this.serializeAs_GuildInformationsGeneralMessage(param1);
      }
      
      public function serializeAs_GuildInformationsGeneralMessage(param1:IDataOutput) : void {
         var _loc2_:uint = 0;
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,0,this.enabled);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,1,this.abandonnedPaddock);
         param1.writeByte(_loc2_);
         if(this.level < 0 || this.level > 255)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         else
         {
            param1.writeByte(this.level);
            if(this.expLevelFloor < 0)
            {
               throw new Error("Forbidden value (" + this.expLevelFloor + ") on element expLevelFloor.");
            }
            else
            {
               param1.writeDouble(this.expLevelFloor);
               if(this.experience < 0)
               {
                  throw new Error("Forbidden value (" + this.experience + ") on element experience.");
               }
               else
               {
                  param1.writeDouble(this.experience);
                  if(this.expNextLevelFloor < 0)
                  {
                     throw new Error("Forbidden value (" + this.expNextLevelFloor + ") on element expNextLevelFloor.");
                  }
                  else
                  {
                     param1.writeDouble(this.expNextLevelFloor);
                     if(this.creationDate < 0)
                     {
                        throw new Error("Forbidden value (" + this.creationDate + ") on element creationDate.");
                     }
                     else
                     {
                        param1.writeInt(this.creationDate);
                        return;
                     }
                  }
               }
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildInformationsGeneralMessage(param1);
      }
      
      public function deserializeAs_GuildInformationsGeneralMessage(param1:IDataInput) : void {
         var _loc2_:uint = param1.readByte();
         this.enabled = BooleanByteWrapper.getFlag(_loc2_,0);
         this.abandonnedPaddock = BooleanByteWrapper.getFlag(_loc2_,1);
         this.level = param1.readUnsignedByte();
         if(this.level < 0 || this.level > 255)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of GuildInformationsGeneralMessage.level.");
         }
         else
         {
            this.expLevelFloor = param1.readDouble();
            if(this.expLevelFloor < 0)
            {
               throw new Error("Forbidden value (" + this.expLevelFloor + ") on element of GuildInformationsGeneralMessage.expLevelFloor.");
            }
            else
            {
               this.experience = param1.readDouble();
               if(this.experience < 0)
               {
                  throw new Error("Forbidden value (" + this.experience + ") on element of GuildInformationsGeneralMessage.experience.");
               }
               else
               {
                  this.expNextLevelFloor = param1.readDouble();
                  if(this.expNextLevelFloor < 0)
                  {
                     throw new Error("Forbidden value (" + this.expNextLevelFloor + ") on element of GuildInformationsGeneralMessage.expNextLevelFloor.");
                  }
                  else
                  {
                     this.creationDate = param1.readInt();
                     if(this.creationDate < 0)
                     {
                        throw new Error("Forbidden value (" + this.creationDate + ") on element of GuildInformationsGeneralMessage.creationDate.");
                     }
                     else
                     {
                        return;
                     }
                  }
               }
            }
         }
      }
   }
}
