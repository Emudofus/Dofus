package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   
   public class GuildInformationsGeneralMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildInformationsGeneralMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5557;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var enabled:Boolean = false;
      
      public var abandonnedPaddock:Boolean = false;
      
      public var level:uint = 0;
      
      public var expLevelFloor:Number = 0;
      
      public var experience:Number = 0;
      
      public var expNextLevelFloor:Number = 0;
      
      public var creationDate:uint = 0;
      
      public var nbTotalMembers:uint = 0;
      
      public var nbConnectedMembers:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5557;
      }
      
      public function initGuildInformationsGeneralMessage(param1:Boolean = false, param2:Boolean = false, param3:uint = 0, param4:Number = 0, param5:Number = 0, param6:Number = 0, param7:uint = 0, param8:uint = 0, param9:uint = 0) : GuildInformationsGeneralMessage
      {
         this.enabled = param1;
         this.abandonnedPaddock = param2;
         this.level = param3;
         this.expLevelFloor = param4;
         this.experience = param5;
         this.expNextLevelFloor = param6;
         this.creationDate = param7;
         this.nbTotalMembers = param8;
         this.nbConnectedMembers = param9;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.enabled = false;
         this.abandonnedPaddock = false;
         this.level = 0;
         this.expLevelFloor = 0;
         this.experience = 0;
         this.expNextLevelFloor = 0;
         this.creationDate = 0;
         this.nbTotalMembers = 0;
         this.nbConnectedMembers = 0;
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
         this.serializeAs_GuildInformationsGeneralMessage(param1);
      }
      
      public function serializeAs_GuildInformationsGeneralMessage(param1:ICustomDataOutput) : void
      {
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
            if(this.expLevelFloor < 0 || this.expLevelFloor > 9.007199254740992E15)
            {
               throw new Error("Forbidden value (" + this.expLevelFloor + ") on element expLevelFloor.");
            }
            else
            {
               param1.writeVarLong(this.expLevelFloor);
               if(this.experience < 0 || this.experience > 9.007199254740992E15)
               {
                  throw new Error("Forbidden value (" + this.experience + ") on element experience.");
               }
               else
               {
                  param1.writeVarLong(this.experience);
                  if(this.expNextLevelFloor < 0 || this.expNextLevelFloor > 9.007199254740992E15)
                  {
                     throw new Error("Forbidden value (" + this.expNextLevelFloor + ") on element expNextLevelFloor.");
                  }
                  else
                  {
                     param1.writeVarLong(this.expNextLevelFloor);
                     if(this.creationDate < 0)
                     {
                        throw new Error("Forbidden value (" + this.creationDate + ") on element creationDate.");
                     }
                     else
                     {
                        param1.writeInt(this.creationDate);
                        if(this.nbTotalMembers < 0)
                        {
                           throw new Error("Forbidden value (" + this.nbTotalMembers + ") on element nbTotalMembers.");
                        }
                        else
                        {
                           param1.writeVarShort(this.nbTotalMembers);
                           if(this.nbConnectedMembers < 0)
                           {
                              throw new Error("Forbidden value (" + this.nbConnectedMembers + ") on element nbConnectedMembers.");
                           }
                           else
                           {
                              param1.writeVarShort(this.nbConnectedMembers);
                              return;
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GuildInformationsGeneralMessage(param1);
      }
      
      public function deserializeAs_GuildInformationsGeneralMessage(param1:ICustomDataInput) : void
      {
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
            this.expLevelFloor = param1.readVarUhLong();
            if(this.expLevelFloor < 0 || this.expLevelFloor > 9.007199254740992E15)
            {
               throw new Error("Forbidden value (" + this.expLevelFloor + ") on element of GuildInformationsGeneralMessage.expLevelFloor.");
            }
            else
            {
               this.experience = param1.readVarUhLong();
               if(this.experience < 0 || this.experience > 9.007199254740992E15)
               {
                  throw new Error("Forbidden value (" + this.experience + ") on element of GuildInformationsGeneralMessage.experience.");
               }
               else
               {
                  this.expNextLevelFloor = param1.readVarUhLong();
                  if(this.expNextLevelFloor < 0 || this.expNextLevelFloor > 9.007199254740992E15)
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
                        this.nbTotalMembers = param1.readVarUhShort();
                        if(this.nbTotalMembers < 0)
                        {
                           throw new Error("Forbidden value (" + this.nbTotalMembers + ") on element of GuildInformationsGeneralMessage.nbTotalMembers.");
                        }
                        else
                        {
                           this.nbConnectedMembers = param1.readVarUhShort();
                           if(this.nbConnectedMembers < 0)
                           {
                              throw new Error("Forbidden value (" + this.nbConnectedMembers + ") on element of GuildInformationsGeneralMessage.nbConnectedMembers.");
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
   }
}
