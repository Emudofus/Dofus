package com.ankamagames.dofus.logic.game.fight.miscs
{


   public class ActionIdConverter extends Object
   {
         

      public function ActionIdConverter() {
         super();
      }

      public static const ACTION_ENCAPSULATE_BINARY_COMMAND:int = 993;

      public static const ACTION_ENDS_TURN:int = -2;

      public static const ACTION_INTERNAL_SEND_ACTION_BUFFER:int = -1;

      public static const ACTION_NO_OPERATION:int = 0;

      public static const ACTION_SEQUENCE_START:int = 83;

      public static const ACTION_SEQUENCE_END:int = 70;

      public static const ACTION_CHARACTER_MOVEMENT:int = 1;

      public static const ACTION_CHARACTER_CHANGE_MAP:int = 2;

      public static const ACTION_CHARACTER_CHANGE_RESPAWN_MAP:int = 3;

      public static const ACTION_CHARACTER_TELEPORT_ON_SAME_MAP:int = 4;

      public static const ACTION_CHARACTER_PUSH:int = 5;

      public static const ACTION_CHARACTER_PULL:int = 6;

      public static const ACTION_CHARACTER_DIVORCE_WIFE_OR_HUSBAND:int = 7;

      public static const ACTION_CHARACTER_EXCHANGE_PLACES:int = 8;

      public static const ACTION_CHARACTER_DODGE_HIT:int = 9;

      public static const ACTION_CHARACTER_LEARN_EMOTICON:int = 10;

      public static const ACTION_CHARACTER_SET_DIRECTION:int = 11;

      public static const ACTION_CHARACTER_CREATE_GUILD:int = 12;

      public static const ACTION_USE_PUSHPULL_ELEMENT:int = 14;

      public static const ACTION_AREA_CHANGE_ALIGNMENT:int = 15;

      public static const ACTION_AREA_GIVE_KAMAS:int = 16;

      public static const ACTION_SCRIPT_START:int = 17;

      public static const ACTION_AREA_DUNGEON_ATTACKED:int = 20;

      public static const ACTION_GAIN_AREA_KAMAS:int = 21;

      public static const ACTION_AREA_DUNGEON_CITY_OPENED:int = 23;

      public static const ACTION_AREA_DUNGEON_HEART_OPENED:int = 24;

      public static const ACTION_AREA_DUNGEON_HEART_CLOSED:int = 25;

      public static const ACTION_AREA_CHANGE_ALIGNMENT_SUB:int = 26;

      public static const ACTION_QUEST_OBJECTIVE_VALIDATE:int = 30;

      public static const ACTION_QUEST_STEP_VALIDATE:int = 31;

      public static const ACTION_QUEST_QUEST_VALIDATE:int = 32;

      public static const ACTION_QUEST_STEP_START:int = 33;

      public static const ACTION_QUEST_START:int = 34;

      public static const ACTION_QUEST_CHECK_STARTED_OBJECTIVES:int = 35;

      public static const ACTION_QUEST_RESET:int = 36;

      public static const ACTION_START_DIALOG_WITH_NPC:int = 40;

      public static const ACTION_CARRY_CHARACTER:int = 50;

      public static const ACTION_THROW_CARRIED_CHARACTER:int = 51;

      public static const ACTION_NO_MORE_CARRIED:int = 52;

      public static const ACTION_CHARACTER_MOVEMENT_POINTS_STEAL:int = 77;

      public static const ACTION_CHARACTER_MOVEMENT_POINTS_WIN:int = 78;

      public static const ACTION_CHARACTER_MULTIPLY_RECEIVED_DAMAGE_OR_GIVE_LIFE_WITH_RATIO:int = 79;

      public static const ACTION_CHARACTER_LIFE_POINTS_LOST_FROM_PUSH:int = 80;

      public static const ACTION_CHARACTER_LIFE_POINTS_WIN_WITHOUT_ELEMENT:int = 81;

      public static const ACTION_CHARACTER_LIFE_POINTS_STEAL_WITHOUT_BOOST:int = 82;

      public static const ACTION_CHARACTER_ACTION_POINTS_STEAL:int = 84;

      public static const ACTION_CHARACTER_LIFE_POINTS_LOST_BASED_ON_CASTER_LIFE_FROM_WATER:int = 85;

      public static const ACTION_CHARACTER_LIFE_POINTS_LOST_BASED_ON_CASTER_LIFE_FROM_EARTH:int = 86;

      public static const ACTION_CHARACTER_LIFE_POINTS_LOST_BASED_ON_CASTER_LIFE_FROM_AIR:int = 87;

      public static const ACTION_CHARACTER_LIFE_POINTS_LOST_BASED_ON_CASTER_LIFE_FROM_FIRE:int = 88;

      public static const ACTION_CHARACTER_LIFE_POINTS_LOST_BASED_ON_CASTER_LIFE:int = 89;

      public static const ACTION_CHARACTER_DISPATCH_LIFE_POINTS_PERCENT:int = 90;

      public static const ACTION_CHARACTER_LIFE_POINTS_STEAL_FROM_WATER:int = 91;

      public static const ACTION_CHARACTER_LIFE_POINTS_STEAL_FROM_EARTH:int = 92;

      public static const ACTION_CHARACTER_LIFE_POINTS_STEAL_FROM_AIR:int = 93;

      public static const ACTION_CHARACTER_LIFE_POINTS_STEAL_FROM_FIRE:int = 94;

      public static const ACTION_CHARACTER_LIFE_POINTS_STEAL:int = 95;

      public static const ACTION_CHARACTER_LIFE_POINTS_LOST_FROM_WATER:int = 96;

      public static const ACTION_CHARACTER_LIFE_POINTS_LOST_FROM_EARTH:int = 97;

      public static const ACTION_CHARACTER_LIFE_POINTS_LOST_FROM_AIR:int = 98;

      public static const ACTION_CHARACTER_LIFE_POINTS_LOST_FROM_FIRE:int = 99;

      public static const ACTION_CHARACTER_LIFE_POINTS_MALUS:int = 1047;

      public static const ACTION_CHARACTER_LIFE_POINTS_MALUS_PERCENT:int = 1048;

      public static const ACTION_CHARACTER_LIFE_POINTS_LOST:int = 100;

      public static const ACTION_CHARACTER_ACTION_POINTS_LOST:int = 101;

      public static const ACTION_CHARACTER_ACTION_POINTS_USE:int = 102;

      public static const ACTION_CHARACTER_DEATH:int = 103;

      public static const ACTION_CHARACTER_ACTION_TACKLED:int = 104;

      public static const ACTION_CHARACTER_LIFE_LOST_MODERATOR:int = 105;

      public static const ACTION_CHARACTER_LIFE_LOST_CASTER_MODERATOR:int = 265;

      public static const ACTION_CHARACTER_SPELL_REFLECTOR:int = 106;

      public static const ACTION_CHARACTER_LIFE_LOST_REFLECTOR:int = 107;

      public static const ACTION_CHARACTER_LIFE_POINTS_WIN:int = 108;

      public static const ACTION_CHARACTER_LIFE_POINTS_LOST_CASTER:int = 109;

      public static const ACTION_CHARACTER_BOOST_LIFE_POINTS:int = 110;

      public static const ACTION_CHARACTER_BOOST_ACTION_POINTS:int = 111;

      public static const ACTION_CHARACTER_BOOST_DAMAGES:int = 112;

      public static const ACTION_CHARACTER_MULTIPLY_DAMAGES:int = 114;

      public static const ACTION_CHARACTER_BOOST_CRITICAL_HIT:int = 115;

      public static const ACTION_CHARACTER_DEBOOST_RANGE:int = 116;

      public static const ACTION_CHARACTER_BOOST_RANGE:int = 117;

      public static const ACTION_CHARACTER_BOOST_STRENGTH:int = 118;

      public static const ACTION_CHARACTER_BOOST_AGILITY:int = 119;

      public static const ACTION_CHARACTER_ACTION_POINTS_WIN:int = 120;

      public static const ACTION_CHARACTER_BOOST_DAMAGES_FOR_ALL_GAME:int = 121;

      public static const ACTION_CHARACTER_BOOST_CRITICAL_MISS:int = 122;

      public static const ACTION_CHARACTER_BOOST_CHANCE:int = 123;

      public static const ACTION_CHARACTER_BOOST_WISDOM:int = 124;

      public static const ACTION_CHARACTER_BOOST_VITALITY:int = 125;

      public static const ACTION_CHARACTER_BOOST_INTELLIGENCE:int = 126;

      public static const ACTION_CHARACTER_MOVEMENT_POINTS_LOST:int = 127;

      public static const ACTION_CHARACTER_BOOST_MOVEMENT_POINTS:int = 128;

      public static const ACTION_CHARACTER_MOVEMENT_POINTS_USE:int = 129;

      public static const ACTION_CHARACTER_STEAL_GOLD:int = 130;

      public static const ACTION_CHARACTER_MANA_USE_KILL_LIFE:int = 131;

      public static const ACTION_CHARACTER_REMOVE_ALL_EFFECTS:int = 132;

      public static const ACTION_CHARACTER_ACTION_POINTS_LOST_CASTER:int = 133;

      public static const ACTION_CHARACTER_MOVEMEMT_POINTS_LOST_CASTER:int = 134;

      public static const ACTION_CHARACTER_DEBOOST_RANGE_CASTER:int = 135;

      public static const ACTION_CHARACTER_BOOST_RANGE_CASTER:int = 136;

      public static const ACTION_CHARACTER_BOOST_DAMAGES_CASTER:int = 137;

      public static const ACTION_CHARACTER_BOOST_DAMAGES_PERCENT:int = 138;

      public static const ACTION_CHARACTER_DEBOOST_DAMAGES_PERCENT:int = 186;

      public static const ACTION_CHARACTER_ENERGY_POINTS_WIN:int = 139;

      public static const ACTION_CHARACTER_PASS_NEXT_TURN:int = 140;

      public static const ACTION_CHARACTER_KILL:int = 141;

      public static const ACTION_CHARACTER_BOOST_PHYSICAL_DAMAGES:int = 142;

      public static const ACTION_CHARACTER_LIFE_POINTS_WIN_WITHOUT_BOOST:int = 143;

      public static const ACTION_CHARACTER_LIFE_POINTS_LOST_WITHOUT_BOOST:int = 144;

      public static const ACTION_CHARACTER_DEBOOST_DAMAGES:int = 145;

      public static const ACTION_CHARACTER_CURSE:int = 146;

      public static const ACTION_CHARACTER_RESURECT_ALLY_IN_FIGHT:int = 147;

      public static const ACTION_CHARACTER_ADD_FOLLOWING_CHARACTER:int = 148;

      public static const ACTION_CHARACTER_MAKE_INVISIBLE:int = 150;

      public static const ACTION_SPELL_INVISIBLE_OBSTACLE:int = 151;

      public static const ACTION_CHARACTER_CHANGE_COLOR:int = 333;

      public static const ACTION_CHARACTER_CHANGE_LOOK:int = 149;

      public static const ACTION_CHARACTER_ADD_APPEARANCE:int = 335;

      public static const ACTION_CHARACTER_DEBOOST_CHANCE:int = 152;

      public static const ACTION_CHARACTER_DEBOOST_VITALITY:int = 153;

      public static const ACTION_CHARACTER_DEBOOST_AGILITY:int = 154;

      public static const ACTION_CHARACTER_DEBOOST_INTELLIGENCE:int = 155;

      public static const ACTION_CHARACTER_DEBOOST_WISDOM:int = 156;

      public static const ACTION_CHARACTER_DEBOOST_STRENGTH:int = 157;

      public static const ACTION_CHARACTER_BOOST_MAXIMUM_WEIGHT:int = 158;

      public static const ACTION_CHARACTER_DEBOOST_MAXIMUM_WEIGHT:int = 159;

      public static const ACTION_CHARACTER_BOOST_ACTION_POINTS_LOST_DODGE:int = 160;

      public static const ACTION_CHARACTER_BOOST_MOVEMENT_POINTS_LOST_DODGE:int = 161;

      public static const ACTION_CHARACTER_DEBOOST_ACTION_POINTS_LOST_DODGE:int = 162;

      public static const ACTION_CHARACTER_DEBOOST_MOVEMENT_POINTS_LOST_DODGE:int = 163;

      public static const ACTION_CHARACTER_BOOST_DODGE:int = 752;

      public static const ACTION_CHARACTER_BOOST_TACKLE:int = 753;

      public static const ACTION_CHARACTER_DEBOOST_DODGE:int = 754;

      public static const ACTION_CHARACTER_DEBOOST_TACKLE:int = 755;

      public static const ACTION_CHARACTER_BOOST_WEAPON_DAMAGE_PERCENT:int = 165;

      public static const ACTION_CHARACTER_DEBOOST_ACTION_POINTS:int = 168;

      public static const ACTION_CHARACTER_DEBOOST_MOVEMENT_POINTS:int = 169;

      public static const ACTION_CHARACTER_LIFE_POINTS_WIN_IN_RP:int = 170;

      public static const ACTION_CHARACTER_DEBOOST_CRITICAL_HIT:int = 171;

      public static const ACTION_CHARACTER_DEBOOST_MAGICAL_REDUCTION:int = 172;

      public static const ACTION_CHARACTER_DEBOOST_PHYSICAL_REDUCTION:int = 173;

      public static const ACTION_CHARACTER_BOOST_INITIATIVE:int = 174;

      public static const ACTION_CHARACTER_DEBOOST_INITIATIVE:int = 175;

      public static const ACTION_CHARACTER_BOOST_MAGIC_FIND:int = 176;

      public static const ACTION_CHARACTER_DEBOOST_MAGIC_FIND:int = 177;

      public static const ACTION_CHARACTER_BOOST_HEAL_BONUS:int = 178;

      public static const ACTION_CHARACTER_DEBOOST_HEAL_BONUS:int = 179;

      public static const ACTION_CHARACTER_ADD_DOUBLE:int = 180;

      public static const ACTION_SUMMON_CREATURE:int = 181;

      public static const ACTION_CHARACTER_BOOST_MAXIMUM_SUMMONED_CREATURES:int = 182;

      public static const ACTION_CHARACTER_BOOST_MAGICAL_REDUCTION:int = 183;

      public static const ACTION_CHARACTER_BOOST_PHYSICAL_REDUCTION:int = 184;

      public static const ACTION_SUMMON_STATIC_CREATURE:int = 185;

      public static const ACTION_CHARACTER_ALIGNMENT_RANK_SET:int = 187;

      public static const ACTION_CHARACTER_ALIGNMENT_SIDE_SET:int = 188;

      public static const ACTION_CHARACTER_ALIGNMENT_VALUE_SET:int = 189;

      public static const ACTION_CHARACTER_ALIGNMENT_VALUE_MODIFICATION:int = 190;

      public static const ACTION_CHARACTER_INVENTORY_CLEAR:int = 191;

      public static const ACTION_CHARACTER_INVENTORY_REMOVE_ITEM:int = 192;

      public static const ACTION_CHARACTER_INVENTORY_ADD_ITEM:int = 193;

      public static const ACTION_CHARACTER_INVENTORY_ADD_ITEM_NOCHECK:int = 209;

      public static const ACTION_CHARACTER_INVENTORY_ADD_ITEM_RANDOM_NOCHECK:int = 221;

      public static const ACTION_CHARACTER_INVENTORY_ADD_ITEM_FROM_RANDOM_DROP:int = 222;

      public static const ACTION_CHARACTER_INVENTORY_GAIN_KAMAS:int = 194;

      public static const ACTION_CHARACTER_INVENTORY_LOSE_KAMAS:int = 195;

      public static const ACTION_CHARACTER_OPEN_MY_STORAGE:int = 196;

      public static const ACTION_CHARACTER_TRANSFORM:int = 197;

      public static const ACTION_CHARACTER_CLEAR_ALL_JOB:int = 198;

      public static const ACTION_CHARACTER_REPAIR_OBJECT:int = 199;

      public static const ACTION_CHARACTER_INVENTORY_ADD_ITEM_ON_RP_MAP:int = 232;

      public static const ACTION_CHARACTER_INVENTORY_REMOVE_ITEM_ON_RP_MAP:int = 233;

      public static const ACTION_DECORS_PLAY_OBJECT_ANIMATION:int = 200;

      public static const ACTION_DECORS_ADD_OBJECT:int = 201;

      public static const ACTION_DECORS_REVEAL_UNVISIBLE:int = 202;

      public static const ACTION_DECORS_OBSTACLE_CLOSE:int = 203;

      public static const ACTION_DECORS_OBSTACLE_OPEN:int = 204;

      public static const ACTION_CHARACTER_CHANGE_RESTRICTION:int = 205;

      public static const ACTION_CHARACTER_RESURRECTION:int = 206;

      public static const ACTION_COLLECT_RESOURCE:int = 207;

      public static const ACTION_DECORS_PLAY_ANIMATION:int = 208;

      public static const ACTION_DECORS_PLAY_ANIMATION_UNLIGHTED:int = 228;

      public static const ACTION_CHARACTER_BOOST_EARTH_ELEMENT_PERCENT:int = 210;

      public static const ACTION_CHARACTER_BOOST_WATER_ELEMENT_PERCENT:int = 211;

      public static const ACTION_CHARACTER_BOOST_AIR_ELEMENT_PERCENT:int = 212;

      public static const ACTION_CHARACTER_BOOST_FIRE_ELEMENT_PERCENT:int = 213;

      public static const ACTION_CHARACTER_BOOST_NEUTRAL_ELEMENT_PERCENT:int = 214;

      public static const ACTION_CHARACTER_DEBOOST_EARTH_ELEMENT_PERCENT:int = 215;

      public static const ACTION_CHARACTER_DEBOOST_WATER_ELEMENT_PERCENT:int = 216;

      public static const ACTION_CHARACTER_DEBOOST_AIR_ELEMENT_PERCENT:int = 217;

      public static const ACTION_CHARACTER_DEBOOST_FIRE_ELEMENT_PERCENT:int = 218;

      public static const ACTION_CHARACTER_DEBOOST_NEUTRAL_ELEMENT_PERCENT:int = 219;

      public static const ACTION_CHARACTER_REFLECTOR_UNBOOSTED:int = 220;

      public static const ACTION_DECORS_OBSTACLE_CLOSE_RANDOM:int = 223;

      public static const ACTION_DECORS_OBSTACLE_OPEN_RANDOM:int = 224;

      public static const ACTION_CHARACTER_BOOST_TRAP:int = 225;

      public static const ACTION_CHARACTER_BOOST_TRAP_PERCENT:int = 226;

      public static const ACTION_CHARACTER_GAIN_RIDE:int = 229;

      public static const ACTION_CHARACTER_ENERGY_LOSS_BOOST:int = 230;

      public static const ACTION_CHARACTER_ENERGY_POINTS_LOOSE:int = 231;

      public static const ACTION_CHARACTER_BOOST_EARTH_ELEMENT_RESIST:int = 240;

      public static const ACTION_CHARACTER_BOOST_WATER_ELEMENT_RESIST:int = 241;

      public static const ACTION_CHARACTER_BOOST_AIR_ELEMENT_RESIST:int = 242;

      public static const ACTION_CHARACTER_BOOST_FIRE_ELEMENT_RESIST:int = 243;

      public static const ACTION_CHARACTER_BOOST_NEUTRAL_ELEMENT_RESIST:int = 244;

      public static const ACTION_CHARACTER_DEBOOST_EARTH_ELEMENT_RESIST:int = 245;

      public static const ACTION_CHARACTER_DEBOOST_WATER_ELEMENT_RESIST:int = 246;

      public static const ACTION_CHARACTER_DEBOOST_AIR_ELEMENT_RESIST:int = 247;

      public static const ACTION_CHARACTER_DEBOOST_FIRE_ELEMENT_RESIST:int = 248;

      public static const ACTION_CHARACTER_DEBOOST_NEUTRAL_ELEMENT_RESIST:int = 249;

      public static const ACTION_CHARACTER_BOOST_EARTH_ELEMENT_PVP_PERCENT:int = 250;

      public static const ACTION_CHARACTER_BOOST_WATER_ELEMENT_PVP_PERCENT:int = 251;

      public static const ACTION_CHARACTER_BOOST_AIR_ELEMENT_PVP_PERCENT:int = 252;

      public static const ACTION_CHARACTER_BOOST_FIRE_ELEMENT_PVP_PERCENT:int = 253;

      public static const ACTION_CHARACTER_BOOST_NEUTRAL_ELEMENT_PVP_PERCENT:int = 254;

      public static const ACTION_CHARACTER_DEBOOST_EARTH_ELEMENT_PVP_PERCENT:int = 255;

      public static const ACTION_CHARACTER_DEBOOST_WATER_ELEMENT_PVP_PERCENT:int = 256;

      public static const ACTION_CHARACTER_DEBOOST_AIR_ELEMENT_PVP_PERCENT:int = 257;

      public static const ACTION_CHARACTER_DEBOOST_FIRE_ELEMENT_PVP_PERCENT:int = 258;

      public static const ACTION_CHARACTER_DEBOOST_NEUTRAL_ELEMENT_PVP_PERCENT:int = 259;

      public static const ACTION_CHARACTER_BOOST_EARTH_ELEMENT_PVP_RESIST:int = 260;

      public static const ACTION_CHARACTER_BOOST_WATER_ELEMENT_PVP_RESIST:int = 261;

      public static const ACTION_CHARACTER_BOOST_AIR_ELEMENT_PVP_RESIST:int = 262;

      public static const ACTION_CHARACTER_BOOST_FIRE_ELEMENT_PVP_RESIST:int = 263;

      public static const ACTION_CHARACTER_BOOST_NEUTRAL_ELEMENT_PVP_RESIST:int = 264;

      public static const ACTION_CHARACTER_STEAL_CHANCE:int = 266;

      public static const ACTION_CHARACTER_STEAL_VITALITY:int = 267;

      public static const ACTION_CHARACTER_STEAL_AGILITY:int = 268;

      public static const ACTION_CHARACTER_STEAL_INTELLIGENCE:int = 269;

      public static const ACTION_CHARACTER_STEAL_WISDOM:int = 270;

      public static const ACTION_CHARACTER_STEAL_STRENGTH:int = 271;

      public static const ACTION_CHARACTER_LIFE_POINTS_LOST_BASED_ON_CASTER_LIFE_MISSING_FROM_WATER:int = 275;

      public static const ACTION_CHARACTER_LIFE_POINTS_LOST_BASED_ON_CASTER_LIFE_MISSING_FROM_EARTH:int = 276;

      public static const ACTION_CHARACTER_LIFE_POINTS_LOST_BASED_ON_CASTER_LIFE_MISSING_FROM_AIR:int = 277;

      public static const ACTION_CHARACTER_LIFE_POINTS_LOST_BASED_ON_CASTER_LIFE_MISSING_FROM_FIRE:int = 278;

      public static const ACTION_CHARACTER_LIFE_POINTS_LOST_BASED_ON_CASTER_LIFE_MISSING:int = 279;

      public static const ACTION_CHARACTER_BOOST_SHIELD_BASED_ON_CASTER_LIFE:int = 1039;

      public static const ACTION_CHARACTER_BOOST_SHIELD:int = 1040;

      public static const ACTION_CHARACTER_ADD_SPELL_COOLDOWN:int = 1035;

      public static const ACTION_CHARACTER_REMOVE_SPELL_COOLDOWN:int = 1036;

      public static const ACTION_CHARACTER_UPDATE_BOOST:int = 515;

      public static const ACTION_CHARACTER_BOOST_DISPELLED:int = 514;

      public static const ACTION_BOOST_SPELL_RANGE:int = 281;

      public static const ACTION_BOOST_SPELL_RANGEABLE:int = 282;

      public static const ACTION_BOOST_SPELL_DMG:int = 283;

      public static const ACTION_BOOST_SPELL_HEAL:int = 284;

      public static const ACTION_BOOST_SPELL_AP_COST:int = 285;

      public static const ACTION_BOOST_SPELL_CAST_INTVL:int = 286;

      public static const ACTION_BOOST_SPELL_CC:int = 287;

      public static const ACTION_BOOST_SPELL_CASTOUTLINE:int = 288;

      public static const ACTION_BOOST_SPELL_NOLINEOFSIGHT:int = 289;

      public static const ACTION_BOOST_SPELL_MAXPERTURN:int = 290;

      public static const ACTION_BOOST_SPELL_MAXPERTARGET:int = 291;

      public static const ACTION_BOOST_SPELL_CAST_INTVL_SET:int = 292;

      public static const ACTION_BOOST_SPELL_BASE_DMG:int = 293;

      public static const ACTION_DEBOOST_SPELL_RANGE:int = 294;

      public static const ACTION_FIGHT_CAST_SPELL:int = 300;

      public static const ACTION_FIGHT_CAST_SPELL_CRITICAL_HIT:int = 301;

      public static const ACTION_FIGHT_CAST_SPELL_CRITICAL_MISS:int = 302;

      public static const ACTION_FIGHT_CLOSE_COMBAT:int = 303;

      public static const ACTION_FIGHT_CLOSE_COMBAT_CRITICAL_HIT:int = 304;

      public static const ACTION_FIGHT_CLOSE_COMBAT_CRITICAL_MISS:int = 305;

      public static const ACTION_FIGHT_TRIGGER_TRAP:int = 306;

      public static const ACTION_FIGHT_TRIGGER_GLYPH:int = 307;

      public static const ACTION_FIGHT_SPELL_DODGED_PA:int = 308;

      public static const ACTION_FIGHT_SPELL_DODGED_PM:int = 309;

      public static const ACTION_CHARACTER_STEAL_RANGE:int = 320;

      public static const ACTION_FIGHT_ADD_TRAP_CASTING_SPELL:int = 400;

      public static const ACTION_FIGHT_ADD_GLYPH_CASTING_SPELL:int = 401;

      public static const ACTION_FIGHT_ADD_GLYPH_CASTING_SPELL_ENDTURN:int = 402;

      public static const ACTION_FIGHT_KILL_AND_SUMMON:int = 405;

      public static const ACTION_INTERACTIVE_ELEMENT:int = 500;

      public static const ACTION_SKILL_ANIMATION:int = 501;

      public static const ACTION_EXCHANGE_CRAFT_OPEN:int = 502;

      public static const ACTION_USE_WAYPOINT:int = 503;

      public static const ACTION_DO_ELEMENT_PARAMETERIZED_OPERATION:int = 505;

      public static const ACTION_INTERACTIVE_ELEMENT_AT_HOME_INNER_DOOR:int = 507;

      public static const ACTION_SAVE_WAYPOINT:int = 508;

      public static const ACTION_CHANGE_COMPASS:int = 509;

      public static const ACTION_USE_SUBWAY:int = 510;

      public static const ACTION_EXCHANGE_JOBINDEX_OPEN:int = 511;

      public static const ACTION_USE_PRISM:int = 512;

      public static const ACTION_ADD_PRISM:int = 513;

      public static const ACTION_GOTO_WAYPOINT:int = 600;

      public static const ACTION_GOTO_MAP:int = 601;

      public static const ACTION_CHARACTER_LEARN_JOB:int = 603;

      public static const ACTION_CHARACTER_LEARN_SPELL:int = 604;

      public static const ACTION_CHARACTER_GAIN_XP:int = 605;

      public static const ACTION_CHARACTER_GAIN_WISDOM:int = 606;

      public static const ACTION_CHARACTER_GAIN_STRENGTH:int = 607;

      public static const ACTION_CHARACTER_GAIN_CHANCE:int = 608;

      public static const ACTION_CHARACTER_GAIN_AGILITY:int = 609;

      public static const ACTION_CHARACTER_GAIN_VITALITY:int = 610;

      public static const ACTION_CHARACTER_GAIN_INTELLIGENCE:int = 611;

      public static const ACTION_CHARACTER_GAIN_STATS_POINTS:int = 612;

      public static const ACTION_CHARACTER_GAIN_SPELL_POINTS:int = 613;

      public static const ACTION_CHARACTER_GAIN_JOB_XP:int = 614;

      public static const ACTION_CHARACTER_UNLEARN_JOB:int = 615;

      public static const ACTION_CHARACTER_UNBOOST_SPELL:int = 616;

      public static const ACTION_CHARACTER_GET_MARRIED:int = 617;

      public static const ACTION_CHARACTER_GET_MARRIED_ACCEPT:int = 618;

      public static const ACTION_CHARACTER_GET_MARRIED_DECLINE:int = 619;

      public static const ACTION_CHARACTER_READ_BOOK:int = 620;

      public static const ACTION_CHARACTER_SUMMON_MONSTER:int = 621;

      public static const ACTION_GOTO_HOUSE:int = 622;

      public static const ACTION_CHARACTER_SUMMON_MONSTER_GROUP:int = 623;

      public static const ACTION_CHARACTER_SUMMON_MONSTER_GROUP_SET_MAP:int = 627;

      public static const ACTION_CHARACTER_SUMMON_MONSTER_GROUP_DYNAMIC:int = 628;

      public static const ACTION_CHARACTER_UNLEARN_GUILDSPELL:int = 624;

      public static const ACTION_CHARACTER_UNBOOST_CARACS:int = 625;

      public static const ACTION_CHARACTER_UNBOOST_CARACS_TO_101:int = 626;

      public static const ACTION_CHARACTER_SEND_INFORMATION_TEXT:int = 630;

      public static const ACTION_CHARACTER_SEND_DIALOG_ACTION:int = 631;

      public static const ACTION_CHARACTER_GAIN_HONOUR:int = 640;

      public static const ACTION_CHARACTER_GAIN_DISHONOUR:int = 641;

      public static const ACTION_CHARACTER_LOOSE_HONOUR:int = 642;

      public static const ACTION_CHARACTER_LOOSE_DISHONOUR:int = 643;

      public static const ACTION_MAP_RESURECTION_ALLIES:int = 645;

      public static const ACTION_MAP_HEAL_ALLIES:int = 646;

      public static const ACTION_MAP_FORCE_ENNEMIES_GHOST:int = 647;

      public static const ACTION_FORCE_ENNEMY_GHOST:int = 648;

      public static const ACTION_FAKE_ALIGNMENT:int = 649;

      public static const ACTION_TELEPORT_NOOBY_MAP:int = 650;

      public static const ACTION_USE_ELEMENT_ACTIONS:int = 651;

      public static const ACTION_SET_STATED_ELEMENT_STATE:int = 652;

      public static const ACTION_RESET_STATED_ELEMENT:int = 653;

      public static const ACTION_HOUSE_LEAVE:int = 654;

      public static const ACTION_NOOP:int = 666;

      public static const ACTION_INCARNATION:int = 669;

      public static const ACTION_CHARACTER_REFERENCEMENT:int = 699;

      public static const ACTION_ITEM_CHANGE_EFFECT:int = 700;

      public static const ACTION_ITEM_ADD_EFFECT:int = 701;

      public static const ACTION_ITEM_ADD_DURABILITY:int = 702;

      public static const ACTION_CAPTURE_SOUL:int = 705;

      public static const ACTION_CAPTURE_RIDE:int = 706;

      public static const ACTION_CHARACTER_ADD_COST_TO_ACTION:int = 710;

      public static const ACTION_LADDER_SUPERRACE:int = 715;

      public static const ACTION_LADDER_RACE:int = 716;

      public static const ACTION_LADDER_ID:int = 717;

      public static const ACTION_PVP_LADDER:int = 720;

      public static const ACTION_VICTIM_OF:int = 721;

      public static const ACTION_GAIN_TEMP_SPELL:int = 722;

      public static const ACTION_GAIN_AURA:int = 723;

      public static const ACTION_GAIN_TITLE:int = 724;

      public static const ACTION_CHARACTER_RENAME_GUILD:int = 725;

      public static const ACTION_TELEPORT_NEAREST_PRISM:int = 730;

      public static const ACTION_AUTO_AGGRESS_ENEMY_PLAYER:int = 731;

      public static const ACTION_SHUSHU_STACK_RUNE:int = 742;

      public static const ACTION_BOOST_SOUL_CAPTURE_BONUS:int = 750;

      public static const ACTION_BOOST_RIDE_XP_BONUS:int = 751;

      public static const ACTION_REMOVE_ON_MOVE:int = 760;

      public static const ACTION_CHARACTER_SACRIFY:int = 765;

      public static const ACTION_HOURLY_CONFUSION_DEGREE:int = 770;

      public static const ACTION_HOURLY_CONFUSION_PI_2:int = 771;

      public static const ACTION_HOURLY_CONFUSION_PI_4:int = 772;

      public static const ACTION_UNHOURLY_CONFUSION_DEGREE:int = 773;

      public static const ACTION_UNHOURLY_CONFUSION_PI_2:int = 774;

      public static const ACTION_UNHOURLY_CONFUSION_PI_4:int = 775;

      public static const ACTION_CHARACTER_BOOST_PERMANENT_DAMAGE_PERCENT:int = 776;

      public static const ACTION_CHARACTER_SUMMON_DEAD_ALLY_IN_FIGHT:int = 780;

      public static const ACTION_CHARACTER_UNLUCKY:int = 781;

      public static const ACTION_CHARACTER_MAXIMIZE_ROLL:int = 782;

      public static const ACTION_CHARACTER_WALK_FOUR_DIR:int = 785;

      public static const ACTION_FIND_BOUNTY_TARGET:int = 790;

      public static const ACTION_MARK_TARGET_MERCENARY:int = 791;

      public static const ACTION_ITEM_CHANGE_PETS_LIFE:int = 800;

      public static const ACTION_ITEM_CHANGE_DURATION:int = 805;

      public static const ACTION_ITEM_PETS_SHAPE:int = 806;

      public static const ACTION_ITEM_PETS_EAT:int = 807;

      public static const ACTION_PETS_LAST_MEAL:int = 808;

      public static const ACTION_ITEM_CHANGE_DURABILITY:int = 812;

      public static const ACTION_ITEM_UPDATE_DATE:int = 813;

      public static const ACTION_ITEM_CHOOSE_IN_ITEM_LIST:int = 820;

      public static const ACTION_CLIENT_OPEN_UI:int = 830;

      public static const PARAM_CLIENT_OPEN_UI_GUILD_TELEPORT_HOUSE:int = 1;

      public static const PARAM_CLIENT_OPEN_UI_GUILD_TELEPORT_FARM:int = 2;

      public static const ACTION_CLIENT_OPEN_UI_SPELL_FORGET:int = 831;

      public static const ACTION_FIGHT_TURN_FINISHED:int = 899;

      public static const ACTION_FIGHT_CHALLENGE:int = 900;

      public static const ACTION_FIGHT_CHALLENGE_ACCEPT:int = 901;

      public static const ACTION_FIGHT_CHALLENGE_DECLINE:int = 902;

      public static const ACTION_FIGHT_CHALLENGE_JOIN:int = 903;

      public static const ACTION_FIGHT_CHALLENGE_AGAINST_MONSTER:int = 905;

      public static const ACTION_FIGHT_AGGRESSION:int = 906;

      public static const ACTION_FIGHT_AGAINST_TAXCOLLECTOR:int = 909;

      public static const ACTION_FIGHT_CHALLENGE_AGAINST_MUTANT:int = 910;

      public static const ACTION_FIGHT_CHALLENGE_MIXED_VERSUS_MONSTER:int = 911;

      public static const ACTION_FIGHT_AGAINST_PRISM:int = 912;

      public static const ACTION_TOOLTIP_ACTIVATE_TIP:int = 915;

      public static const ACTION_PNJ_REMOVE_RIDE:int = 938;

      public static const ACTION_PET_SET_POWER_BOOST:int = 939;

      public static const ACTION_FARM_WITHDRAW_ITEM:int = 947;

      public static const ACTION_FARM_PLACE_ITEM:int = 948;

      public static const ACTION_MOUNT_RIDE:int = 949;

      public static const ACTION_FIGHT_SET_STATE:int = 950;

      public static const ACTION_FIGHT_UNSET_STATE:int = 951;

      public static const ACTION_CREATED_SINCE:int = 963;

      public static const ACTION_SHOW_PLAYERNAME:int = 964;

      public static const ACTION_BOOST_GLOBAL_RESISTS_BONUS:int = 1076;

      public static const ACTION_BOOST_GLOBAL_RESISTS_MALUS:int = 1077;

      private static var _actionInfos:Array;

      private static var _initialized:Boolean = false;

      public static function initialize() : void {
         if(!_initialized)
         {
            _actionInfos=new Array();
            _actionInfos[ACTION_CHARACTER_BOOST_LIFE_POINTS]=["lifePoints",true];
            _actionInfos[ACTION_CHARACTER_MOVEMENT_POINTS_LOST]=["movementPoints",false];
            _actionInfos[ACTION_CHARACTER_BOOST_MOVEMENT_POINTS]=["movementPoints",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_MOVEMENT_POINTS]=["movementPoints",false];
            _actionInfos[ACTION_CHARACTER_ACTION_POINTS_LOST]=["actionPoints",false];
            _actionInfos[ACTION_CHARACTER_BOOST_ACTION_POINTS]=["actionPoints",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_ACTION_POINTS]=["actionPoints",false];
            _actionInfos[ACTION_CHARACTER_DEBOOST_DAMAGES]=["allDamagesBonus",false];
            _actionInfos[ACTION_CHARACTER_BOOST_DAMAGES]=["allDamagesBonus",true];
            _actionInfos[ACTION_CHARACTER_BOOST_PHYSICAL_DAMAGES]=["physicalDamagesBonus",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_DAMAGES_PERCENT]=["damagesBonusPercent",false];
            _actionInfos[ACTION_CHARACTER_BOOST_DAMAGES_PERCENT]=["damagesBonusPercent",true];
            _actionInfos[ACTION_CHARACTER_BOOST_MAXIMUM_SUMMONED_CREATURES]=["summonableCreaturesBoost",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_EARTH_ELEMENT_PERCENT]=["earthElementResistPercent",false];
            _actionInfos[ACTION_CHARACTER_BOOST_EARTH_ELEMENT_PERCENT]=["earthElementResistPercent",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_WATER_ELEMENT_PERCENT]=["waterElementResistPercent",false];
            _actionInfos[ACTION_CHARACTER_BOOST_WATER_ELEMENT_PERCENT]=["waterElementResistPercent",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_AIR_ELEMENT_PERCENT]=["airElementResistPercent",false];
            _actionInfos[ACTION_CHARACTER_BOOST_AIR_ELEMENT_PERCENT]=["airElementResistPercent",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_FIRE_ELEMENT_PERCENT]=["fireElementResistPercent",false];
            _actionInfos[ACTION_CHARACTER_BOOST_FIRE_ELEMENT_PERCENT]=["fireElementResistPercent",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_NEUTRAL_ELEMENT_PERCENT]=["neutralElementResistPercent",false];
            _actionInfos[ACTION_CHARACTER_BOOST_NEUTRAL_ELEMENT_PERCENT]=["neutralElementResistPercent",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_EARTH_ELEMENT_PVP_PERCENT]=["pvpEarthElementResistPercent",false];
            _actionInfos[ACTION_CHARACTER_BOOST_EARTH_ELEMENT_PVP_PERCENT]=["pvpEarthElementResistPercent",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_WATER_ELEMENT_PVP_PERCENT]=["pvpWaterElementResistPercent",false];
            _actionInfos[ACTION_CHARACTER_BOOST_WATER_ELEMENT_PVP_PERCENT]=["pvpWaterElementResistPercent",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_AIR_ELEMENT_PVP_PERCENT]=["pvpAirElementResistPercent",false];
            _actionInfos[ACTION_CHARACTER_BOOST_AIR_ELEMENT_PVP_PERCENT]=["pvpAirElementResistPercent",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_FIRE_ELEMENT_PVP_PERCENT]=["pvpFireElementResistPercent",false];
            _actionInfos[ACTION_CHARACTER_BOOST_FIRE_ELEMENT_PVP_PERCENT]=["pvpFireElementResistPercent",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_NEUTRAL_ELEMENT_PVP_PERCENT]=["pvpNeutralElementResistPercent",false];
            _actionInfos[ACTION_CHARACTER_BOOST_NEUTRAL_ELEMENT_PVP_PERCENT]=["pvpNeutralElementResistPercent",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_RANGE]=["range",false];
            _actionInfos[ACTION_CHARACTER_BOOST_RANGE]=["range",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_STRENGTH]=["strength",false];
            _actionInfos[ACTION_CHARACTER_BOOST_STRENGTH]=["strength",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_AGILITY]=["agility",false];
            _actionInfos[ACTION_CHARACTER_BOOST_AGILITY]=["agility",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_CHANCE]=["chance",false];
            _actionInfos[ACTION_CHARACTER_BOOST_CHANCE]=["chance",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_WISDOM]=["wisdom",false];
            _actionInfos[ACTION_CHARACTER_BOOST_WISDOM]=["wisdom",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_VITALITY]=["vitality",false];
            _actionInfos[ACTION_CHARACTER_BOOST_VITALITY]=["vitality",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_INTELLIGENCE]=["intelligence",false];
            _actionInfos[ACTION_CHARACTER_BOOST_INTELLIGENCE]=["intelligence",true];
            _actionInfos[ACTION_CHARACTER_BOOST_TRAP]=["trapBonus",true];
            _actionInfos[ACTION_CHARACTER_BOOST_TRAP_PERCENT]=["trapBonusPercent",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_EARTH_ELEMENT_RESIST]=["earthElementReduction",false];
            _actionInfos[ACTION_CHARACTER_BOOST_EARTH_ELEMENT_RESIST]=["earthElementReduction",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_WATER_ELEMENT_RESIST]=["waterElementReduction",false];
            _actionInfos[ACTION_CHARACTER_BOOST_WATER_ELEMENT_RESIST]=["waterElementReduction",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_AIR_ELEMENT_RESIST]=["airElementReduction",false];
            _actionInfos[ACTION_CHARACTER_BOOST_AIR_ELEMENT_RESIST]=["airElementReduction",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_FIRE_ELEMENT_RESIST]=["fireElementReduction",false];
            _actionInfos[ACTION_CHARACTER_BOOST_FIRE_ELEMENT_RESIST]=["fireElementReduction",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_NEUTRAL_ELEMENT_RESIST]=["neutralElementReduction",false];
            _actionInfos[ACTION_CHARACTER_BOOST_NEUTRAL_ELEMENT_RESIST]=["neutralElementReduction",true];
            _actionInfos[ACTION_CHARACTER_BOOST_EARTH_ELEMENT_PVP_RESIST]=["pvpEarthElementReduction",true];
            _actionInfos[ACTION_CHARACTER_BOOST_WATER_ELEMENT_PVP_RESIST]=["pvpWaterElementReduction",true];
            _actionInfos[ACTION_CHARACTER_BOOST_AIR_ELEMENT_PVP_RESIST]=["pvpAirElementReduction",true];
            _actionInfos[ACTION_CHARACTER_BOOST_FIRE_ELEMENT_PVP_RESIST]=["pvpFireElementReduction",true];
            _actionInfos[ACTION_CHARACTER_BOOST_NEUTRAL_ELEMENT_PVP_RESIST]=["pvpNeutralElementReduction",true];
            _actionInfos[ACTION_CHARACTER_BOOST_CRITICAL_MISS]=["criticalMiss",true];
            _actionInfos[ACTION_CHARACTER_BOOST_CRITICAL_HIT]=["criticalHit",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_CRITICAL_HIT]=["criticalHit",false];
            _actionInfos[ACTION_CHARACTER_BOOST_INITIATIVE]=["initiative",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_INITIATIVE]=["initiative",false];
            _actionInfos[ACTION_CHARACTER_BOOST_MAGIC_FIND]=["prospecting",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_MAGIC_FIND]=["prospecting",false];
            _actionInfos[ACTION_CHARACTER_BOOST_HEAL_BONUS]=["healBonus",true];
            _actionInfos[ACTION_CHARACTER_BOOST_SHIELD_BASED_ON_CASTER_LIFE]=["shieldPoints",true];
            _actionInfos[ACTION_CHARACTER_BOOST_SHIELD]=["shieldPoints",true];
            _actionInfos[ACTION_CHARACTER_LIFE_POINTS_MALUS]=["lifePointsMalus",false];
            _actionInfos[ACTION_CHARACTER_LIFE_POINTS_MALUS_PERCENT]=["lifePointsMalus",false];
            _actionInfos[ACTION_CHARACTER_REFLECTOR_UNBOOSTED]=["reflectorUnboosted",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_ACTION_POINTS_LOST_DODGE]=["dodgePALostProbability",false];
            _actionInfos[ACTION_CHARACTER_BOOST_ACTION_POINTS_LOST_DODGE]=["dodgePALostProbability",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_MOVEMENT_POINTS_LOST_DODGE]=["dodgePMLostProbability",false];
            _actionInfos[ACTION_CHARACTER_BOOST_MOVEMENT_POINTS_LOST_DODGE]=["dodgePMLostProbability",true];
            _actionInfos[ACTION_CHARACTER_BOOST_DAMAGES_FOR_ALL_GAME]=["allDamagesBonus",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_MAXIMUM_WEIGHT]=["maximumWeight",false];
            _actionInfos[ACTION_CHARACTER_BOOST_MAXIMUM_WEIGHT]=["maximumWeight",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_PHYSICAL_REDUCTION]=["physicalReduction",false];
            _actionInfos[ACTION_CHARACTER_BOOST_PHYSICAL_REDUCTION]=["physicalReduction",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_MAGICAL_REDUCTION]=["magicalReduction",false];
            _actionInfos[ACTION_CHARACTER_BOOST_MAGICAL_REDUCTION]=["magicalReduction",true];
            _actionInfos[ACTION_CHARACTER_BOOST_DODGE]=["tackleEvade",true];
            _actionInfos[ACTION_CHARACTER_BOOST_TACKLE]=["tackleBlock",true];
            _actionInfos[ACTION_CHARACTER_DEBOOST_DODGE]=["tackleEvade",false];
            _actionInfos[ACTION_CHARACTER_DEBOOST_TACKLE]=["tackleBlock",false];
            _actionInfos[ACTION_CHARACTER_BOOST_PERMANENT_DAMAGE_PERCENT]=["permanentDamagePercent",true];
            _actionInfos[ACTION_BOOST_GLOBAL_RESISTS_BONUS]=["globalResistPercentBonus",true];
            _actionInfos[ACTION_BOOST_GLOBAL_RESISTS_MALUS]=["globalResistPercentMalus",true];
            _initialized=true;
         }
      }

      public static function getActionStatName(actionId:int) : String {
         initialize();
         if(_actionInfos[actionId])
         {
            return _actionInfos[actionId][0];
         }
         return null;
      }

      public static function getIsABoost(actionId:int) : Boolean {
         initialize();
         if(_actionInfos[actionId])
         {
            return _actionInfos[actionId][1];
         }
         return false;
      }


   }

}