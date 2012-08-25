// Action script...

// [Initial MovieClip Action of sprite 20696]
#initclip 217
if (!dofus.utils.nameChecker.rules.NameCheckerGuildNameRules)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.utils)
    {
        _global.dofus.utils = new Object();
    } // end if
    if (!dofus.utils.nameChecker)
    {
        _global.dofus.utils.nameChecker = new Object();
    } // end if
    if (!dofus.utils.nameChecker.rules)
    {
        _global.dofus.utils.nameChecker.rules = new Object();
    } // end if
    var _loc1 = (_global.dofus.utils.nameChecker.rules.NameCheckerGuildNameRules = function ()
    {
    }).prototype;
    _loc1.NameCheckerCharacterNameRules = function ()
    {
    };
    _loc1.getMinNameLength = function ()
    {
        return (this.MIN_NAME_LENGTH);
    };
    _loc1.getMaxNameLength = function ()
    {
        return (this.MAX_NAME_LENGTH);
    };
    _loc1.getNumberOfAllowedDashes = function ()
    {
        return (this.NUMBER_OF_ALLOWED_DASHES);
    };
    _loc1.getIsAllowingSpaces = function ()
    {
        return (this.ALLOW_SPACES);
    };
    _loc1.getNoDashesOnTheseIndexes = function ()
    {
        return (this.NO_DASHES_ON_INDEXES);
    };
    _loc1.getIfFirstCharMustBeUppercase = function ()
    {
        return (this.FIRST_CHAR_MUST_BE_UPPERCASE);
    };
    _loc1.getIfNoCharAfterTheFirstMustBeUppercase = function ()
    {
        return (this.NO_UPPERCASE_AFTER_THE_FIRST);
    };
    _loc1.getCharAllowingUppercase = function ()
    {
        return (this.UPPERCASE_ALLOWED_AFTER);
    };
    _loc1.getIfCannotEndWithUppercase = function ()
    {
        return (this.CANNOT_END_WITH_UPPERCASE);
    };
    _loc1.getStrictlyEqualsProhibedWords = function ()
    {
        return (this.PROHIBED_WORDS_STRICTLY_EQUAL);
    };
    _loc1.getContainingProhibedWords = function ()
    {
        return (this.PROHIBED_WORDS_INSIDE);
    };
    _loc1.getBeginningProhibedWords = function ()
    {
        return (this.PROHIBED_WORDS_ON_BEGINNING);
    };
    _loc1.getEndingProhibedWords = function ()
    {
        return (this.PROHIBED_WORDS_ON_ENDING);
    };
    _loc1.getMinimumVowelsCount = function ()
    {
        return (this.AT_LEAST_X_VOWELS);
    };
    _loc1.getMinimumConsonantsCount = function ()
    {
        return (this.AT_LEAST_X_CONSONANTS);
    };
    _loc1.getMaxRepetitionForOneChar = function ()
    {
        return (this.REPETING_CHAR_MAX);
    };
    ASSetPropFlags(_loc1, null, 1);
    _loc1.MIN_NAME_LENGTH = 2;
    _loc1.MAX_NAME_LENGTH = 30;
    _loc1.NUMBER_OF_ALLOWED_DASHES = 3;
    _loc1.ALLOW_SPACES = true;
    _loc1.NO_DASHES_ON_INDEXES = [0, 1];
    _loc1.FIRST_CHAR_MUST_BE_UPPERCASE = true;
    _loc1.NO_UPPERCASE_AFTER_THE_FIRST = true;
    _loc1.UPPERCASE_ALLOWED_AFTER = ["-", " "];
    _loc1.CANNOT_END_WITH_UPPERCASE = true;
    _loc1.PROHIBED_WORDS_STRICTLY_EQUAL = [];
    _loc1.PROHIBED_WORDS_INSIDE = [];
    _loc1.PROHIBED_WORDS_ON_BEGINNING = [];
    _loc1.PROHIBED_WORDS_ON_ENDING = [];
    _loc1.AT_LEAST_X_VOWELS = 1;
    _loc1.AT_LEAST_X_CONSONANTS = 0;
    _loc1.REPETING_CHAR_MAX = 3;
} // end if
#endinitclip
