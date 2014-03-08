package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildInfosUpgradeMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildInfosUpgradeMessage() {
         this.spellId = new Vector.<uint>();
         this.spellLevel = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 5636;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var maxTaxCollectorsCount:uint = 0;
      
      public var taxCollectorsCount:uint = 0;
      
      public var taxCollectorLifePoints:uint = 0;
      
      public var taxCollectorDamagesBonuses:uint = 0;
      
      public var taxCollectorPods:uint = 0;
      
      public var taxCollectorProspecting:uint = 0;
      
      public var taxCollectorWisdom:uint = 0;
      
      public var boostPoints:uint = 0;
      
      public var spellId:Vector.<uint>;
      
      public var spellLevel:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 5636;
      }
      
      public function initGuildInfosUpgradeMessage(param1:uint=0, param2:uint=0, param3:uint=0, param4:uint=0, param5:uint=0, param6:uint=0, param7:uint=0, param8:uint=0, param9:Vector.<uint>=null, param10:Vector.<uint>=null) : GuildInfosUpgradeMessage {
         this.maxTaxCollectorsCount = param1;
         this.taxCollectorsCount = param2;
         this.taxCollectorLifePoints = param3;
         this.taxCollectorDamagesBonuses = param4;
         this.taxCollectorPods = param5;
         this.taxCollectorProspecting = param6;
         this.taxCollectorWisdom = param7;
         this.boostPoints = param8;
         this.spellId = param9;
         this.spellLevel = param10;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.maxTaxCollectorsCount = 0;
         this.taxCollectorsCount = 0;
         this.taxCollectorLifePoints = 0;
         this.taxCollectorDamagesBonuses = 0;
         this.taxCollectorPods = 0;
         this.taxCollectorProspecting = 0;
         this.taxCollectorWisdom = 0;
         this.boostPoints = 0;
         this.spellId = new Vector.<uint>();
         this.spellLevel = new Vector.<uint>();
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
         this.serializeAs_GuildInfosUpgradeMessage(param1);
      }
      
      public function serializeAs_GuildInfosUpgradeMessage(param1:IDataOutput) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ArrayIndexOutOfBoundsException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildInfosUpgradeMessage(param1);
      }
      
      public function deserializeAs_GuildInfosUpgradeMessage(param1:IDataInput) : void {
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         this.maxTaxCollectorsCount = param1.readByte();
         if(this.maxTaxCollectorsCount < 0)
         {
            throw new Error("Forbidden value (" + this.maxTaxCollectorsCount + ") on element of GuildInfosUpgradeMessage.maxTaxCollectorsCount.");
         }
         else
         {
            this.taxCollectorsCount = param1.readByte();
            if(this.taxCollectorsCount < 0)
            {
               throw new Error("Forbidden value (" + this.taxCollectorsCount + ") on element of GuildInfosUpgradeMessage.taxCollectorsCount.");
            }
            else
            {
               this.taxCollectorLifePoints = param1.readShort();
               if(this.taxCollectorLifePoints < 0)
               {
                  throw new Error("Forbidden value (" + this.taxCollectorLifePoints + ") on element of GuildInfosUpgradeMessage.taxCollectorLifePoints.");
               }
               else
               {
                  this.taxCollectorDamagesBonuses = param1.readShort();
                  if(this.taxCollectorDamagesBonuses < 0)
                  {
                     throw new Error("Forbidden value (" + this.taxCollectorDamagesBonuses + ") on element of GuildInfosUpgradeMessage.taxCollectorDamagesBonuses.");
                  }
                  else
                  {
                     this.taxCollectorPods = param1.readShort();
                     if(this.taxCollectorPods < 0)
                     {
                        throw new Error("Forbidden value (" + this.taxCollectorPods + ") on element of GuildInfosUpgradeMessage.taxCollectorPods.");
                     }
                     else
                     {
                        this.taxCollectorProspecting = param1.readShort();
                        if(this.taxCollectorProspecting < 0)
                        {
                           throw new Error("Forbidden value (" + this.taxCollectorProspecting + ") on element of GuildInfosUpgradeMessage.taxCollectorProspecting.");
                        }
                        else
                        {
                           this.taxCollectorWisdom = param1.readShort();
                           if(this.taxCollectorWisdom < 0)
                           {
                              throw new Error("Forbidden value (" + this.taxCollectorWisdom + ") on element of GuildInfosUpgradeMessage.taxCollectorWisdom.");
                           }
                           else
                           {
                              this.boostPoints = param1.readShort();
                              if(this.boostPoints < 0)
                              {
                                 throw new Error("Forbidden value (" + this.boostPoints + ") on element of GuildInfosUpgradeMessage.boostPoints.");
                              }
                              else
                              {
                                 _loc2_ = param1.readUnsignedShort();
                                 _loc3_ = 0;
                                 while(_loc3_ < _loc2_)
                                 {
                                    _loc6_ = param1.readShort();
                                    if(_loc6_ < 0)
                                    {
                                       throw new Error("Forbidden value (" + _loc6_ + ") on elements of spellId.");
                                    }
                                    else
                                    {
                                       this.spellId.push(_loc6_);
                                       _loc3_++;
                                       continue;
                                    }
                                 }
                                 _loc4_ = param1.readUnsignedShort();
                                 _loc5_ = 0;
                                 while(_loc5_ < _loc4_)
                                 {
                                    _loc7_ = param1.readByte();
                                    if(_loc7_ < 0)
                                    {
                                       throw new Error("Forbidden value (" + _loc7_ + ") on elements of spellLevel.");
                                    }
                                    else
                                    {
                                       this.spellLevel.push(_loc7_);
                                       _loc5_++;
                                       continue;
                                    }
                                 }
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
}
