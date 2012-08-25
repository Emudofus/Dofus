// Action script...

// [Initial MovieClip Action of sprite 20971]
#initclip 236
if (!dofus.utils.nameChecker.NameChecker)
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
    var _loc1 = (_global.dofus.utils.nameChecker.NameChecker = function (sName)
    {
        this.name = sName;
        this.upperName = sName.toUpperCase();
        this.lowerName = sName.toLowerCase();
    }).prototype;
    _loc1.isValidAgainst = function (rules)
    {
        if (!this.checkLength(rules.getMinNameLength(), rules.getMaxNameLength()))
        {
            return (false);
        } // end if
        if (!rules.getIsAllowingSpaces() && this.checkContainSpaces())
        {
            return (false);
        } // end if
        if (!this.checkDashesCount(rules.getNumberOfAllowedDashes()))
        {
            return (false);
        } // end if
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < rules.getNoDashesOnTheseIndexes().length)
        {
            if (!this.checkBorderingDashes(rules.getNoDashesOnTheseIndexes()[_loc3]))
            {
                return (false);
            } // end if
        } // end while
        if (rules.getIfFirstCharMustBeUppercase() && !this.checkUpperCaseOnFirstChar())
        {
            return (false);
        } // end if
        if (rules.getIfNoCharAfterTheFirstMustBeUppercase() && !this.checkUpperCaseElsewhere(rules.getCharAllowingUppercase()))
        {
            return (false);
        } // end if
        if (rules.getIfCannotEndWithUppercase() && !this.checkLastIsUppercase())
        {
            return (false);
        } // end if
        if (!this.checkCannotBeEqualTo(rules.getStrictlyEqualsProhibedWords()))
        {
            return (false);
        } // end if
        if (!this.checkCannotContain(rules.getContainingProhibedWords()))
        {
            return (false);
        } // end if
        if (!this.checkCannotStartWith(rules.getBeginningProhibedWords()))
        {
            return (false);
        } // end if
        if (!this.checkCannotEndWith(rules.getEndingProhibedWords()))
        {
            return (false);
        } // end if
        if (!this.checkContainsAtLeastNFromArray(rules.getMinimumVowelsCount(), dofus.utils.nameChecker.NameChecker.VOWELS))
        {
            return (false);
        } // end if
        if (!this.checkContainsAtLeastNFromArray(rules.getMinimumConsonantsCount(), dofus.utils.nameChecker.NameChecker.CONSONANTS))
        {
            return (false);
        } // end if
        if (!this.checkMaximumRepetitionOfSimultaneousLetters(rules.getMaxRepetitionForOneChar()))
        {
            return (false);
        } // end if
        return (true);
    };
    _loc1.isValidAgainstWithDetails = function (rules)
    {
        var _loc3 = new dofus.utils.nameChecker.CheckResults();
        _loc3.IS_SUCCESS = true;
        if (!this.checkLength(rules.getMinNameLength(), rules.getMaxNameLength()))
        {
            _loc3.FAILED_ON_LENGTH_CHECK = true;
            _loc3.IS_SUCCESS = false;
        } // end if
        if (this.name.length == 0)
        {
            _loc3.FAILED_ON_LENGTH_CHECK = true;
            _loc3.IS_SUCCESS = false;
            return (_loc3);
        } // end if
        if (!rules.getIsAllowingSpaces() && this.checkContainSpaces())
        {
            _loc3.FAILED_ON_SPACES_CHECK = true;
            _loc3.IS_SUCCESS = false;
        } // end if
        if (!this.checkDashesCount(rules.getNumberOfAllowedDashes()))
        {
            _loc3.FAILED_ON_DASHES_COUNT_CHECK = true;
            _loc3.IS_SUCCESS = false;
        } // end if
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < rules.getNoDashesOnTheseIndexes().length)
        {
            if (!this.checkBorderingDashes(rules.getNoDashesOnTheseIndexes()[_loc4]))
            {
                _loc3.FAILED_ON_DASHES_AT_INDEXES_CHECK = true;
                _loc3.IS_SUCCESS = false;
                break;
            } // end if
        } // end while
        if (rules.getIfFirstCharMustBeUppercase() && !this.checkUpperCaseOnFirstChar())
        {
            _loc3.FAILED_ON_UPPERCASE_FIRST_CHAR_CHECK = true;
            _loc3.IS_SUCCESS = false;
        } // end if
        if (rules.getIfNoCharAfterTheFirstMustBeUppercase() && !this.checkUpperCaseElsewhere(rules.getCharAllowingUppercase()))
        {
            _loc3.FAILED_ON_UPPERCASE_AFTER_THE_FIRST_CHECK = true;
            _loc3.IS_SUCCESS = false;
        } // end if
        if (rules.getIfCannotEndWithUppercase() && !this.checkLastIsUppercase())
        {
            _loc3.FAILED_ON_UPPERCASE_AT_THE_END_CHECK = true;
            _loc3.IS_SUCCESS = false;
        } // end if
        if (!this.checkCannotBeEqualTo(rules.getStrictlyEqualsProhibedWords()))
        {
            _loc3.FAILED_ON_STRICTLY_EQUALS_PROHIBED_WORDS_CHECK = true;
            _loc3.IS_SUCCESS = false;
        } // end if
        if (!this.checkCannotContain(rules.getContainingProhibedWords()))
        {
            _loc3.FAILED_ON_CONTAINING_PROHIBED_WORDS_CHECK = true;
            _loc3.IS_SUCCESS = false;
        } // end if
        if (!this.checkCannotStartWith(rules.getBeginningProhibedWords()))
        {
            _loc3.FAILED_ON_BEGINNING_WITH_PROHIBED_WORDS_CHECK = true;
            _loc3.IS_SUCCESS = false;
        } // end if
        if (!this.checkCannotEndWith(rules.getEndingProhibedWords()))
        {
            _loc3.FAILED_ON_ENDING_WITH_PROHIBED_WORDS_CHECK = true;
            _loc3.IS_SUCCESS = false;
        } // end if
        if (!this.checkContainsAtLeastNFromArray(rules.getMinimumVowelsCount(), dofus.utils.nameChecker.NameChecker.VOWELS))
        {
            _loc3.FAILED_ON_VOWELS_COUNT_CHECK = true;
            _loc3.IS_SUCCESS = false;
        } // end if
        if (!this.checkContainsAtLeastNFromArray(rules.getMinimumConsonantsCount(), dofus.utils.nameChecker.NameChecker.CONSONANTS))
        {
            _loc3.FAILED_ON_CONSONANTS_COUNT_CHECK = true;
            _loc3.IS_SUCCESS = false;
        } // end if
        if (!this.checkMaximumRepetitionOfSimultaneousLetters(rules.getMaxRepetitionForOneChar()))
        {
            _loc3.FAILED_ON_REPETITION_CHECK = true;
            _loc3.IS_SUCCESS = false;
        } // end if
        return (_loc3);
    };
    _loc1.checkLength = function (nMinLength, nMaxLength)
    {
        if (this.name.length < nMinLength || this.name.length > nMaxLength)
        {
            return (false);
        } // end if
        return (true);
    };
    _loc1.checkContainSpaces = function ()
    {
        var _loc2 = 0;
        
        while (++_loc2, _loc2 < this.name.length)
        {
            if (this.name.charAt(_loc2) == " ")
            {
                return (true);
            } // end if
        } // end while
        return (false);
    };
    _loc1.checkBorderingDashes = function (nIndex)
    {
        if (this.name.charAt(nIndex) == "-" || this.name.charAt(this.name.length - 1 - nIndex) == "-")
        {
            return (false);
        } // end if
        return (true);
    };
    _loc1.checkDashesCount = function (nMaxCount)
    {
        var _loc3 = 0;
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < this.name.length)
        {
            if (this.name.charAt(_loc4) == "-")
            {
                if (++_loc3 > nMaxCount)
                {
                    return (false);
                } // end if
            } // end if
        } // end while
        return (true);
    };
    _loc1.checkUpperCaseOnFirstChar = function ()
    {
        if (this.upperName.charAt(0) != this.name.charAt(0))
        {
            return (false);
        } // end if
        return (true);
    };
    _loc1.checkUpperCaseElsewhere = function (aExceptionsAfter)
    {
        var _loc3 = 1;
        
        while (++_loc3, _loc3 < this.name.length)
        {
            if (this.lowerName.charAt(_loc3) != this.name.charAt(_loc3))
            {
                var _loc4 = false;
                var _loc5 = 0;
                
                while (++_loc5, _loc5 < aExceptionsAfter.length)
                {
                    if (this.name.charAt(_loc3 - 1) == aExceptionsAfter[_loc5])
                    {
                        _loc4 = true;
                    } // end if
                } // end while
                if (!_loc4)
                {
                    return (false);
                } // end if
            } // end if
        } // end while
        return (true);
    };
    _loc1.checkLastIsUppercase = function ()
    {
        if (this.lowerName.charAt(this.name.length - 1) != this.name.charAt(this.name.length - 1))
        {
            return (false);
        } // end if
        return (true);
    };
    _loc1.checkCannotBeEqualTo = function (aProhibedWords)
    {
        if (aProhibedWords == null)
        {
            return (true);
        } // end if
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < aProhibedWords.length)
        {
            if (this.upperName == aProhibedWords[_loc3])
            {
                return (false);
            } // end if
        } // end while
        return (true);
    };
    _loc1.checkCannotContain = function (aProhibedWords)
    {
        if (aProhibedWords == null)
        {
            return (true);
        } // end if
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < aProhibedWords.length)
        {
            if (this.upperName.indexOf(aProhibedWords[_loc3]) > -1)
            {
                return (false);
            } // end if
        } // end while
        return (true);
    };
    _loc1.checkCannotStartWith = function (aProhibedWords)
    {
        if (aProhibedWords == null)
        {
            return (true);
        } // end if
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < aProhibedWords.length)
        {
            if (this.upperName.indexOf(aProhibedWords[_loc3]) == 0)
            {
                return (false);
            } // end if
        } // end while
        return (true);
    };
    _loc1.checkCannotEndWith = function (aProhibedWords)
    {
        if (aProhibedWords == null)
        {
            return (true);
        } // end if
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < aProhibedWords.length)
        {
            if (this.upperName.indexOf(aProhibedWords[_loc3], this.upperName.length - aProhibedWords[_loc3].length) == this.upperName.length - aProhibedWords[_loc3].length)
            {
                return (false);
            } // end if
        } // end while
        return (true);
    };
    _loc1.checkContainsAtLeastNFromArray = function (nCountToContain, aCharsToBeContained)
    {
        var _loc4 = 0;
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < this.name.length)
        {
            var _loc6 = 0;
            
            while (++_loc6, _loc6 < aCharsToBeContained.length)
            {
                if (this.upperName.charAt(_loc5) == aCharsToBeContained[_loc6])
                {
                    if (++_loc4 >= nCountToContain)
                    {
                        return (true);
                    } // end if
                } // end if
            } // end while
        } // end while
        return (false);
    };
    _loc1.checkMaximumRepetitionOfSimultaneousLetters = function (nMaxSimultaneousLetters)
    {
        var _loc3 = new String();
        var _loc4 = 0;
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < this.name.length)
        {
            _loc3 = this.name.charAt(_loc5);
            if (_loc3 == this.name.charAt(_loc5))
            {
                if (++_loc4 > nMaxSimultaneousLetters - 1)
                {
                    return (false);
                } // end if
            } // end if
        } // end while
        return (true);
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.utils.nameChecker.NameChecker = function (sName)
    {
        this.name = sName;
        this.upperName = sName.toUpperCase();
        this.lowerName = sName.toLowerCase();
    }).VOWELS = ["A", "E", "I", "O", "U", "Y"];
    (_global.dofus.utils.nameChecker.NameChecker = function (sName)
    {
        this.name = sName;
        this.upperName = sName.toUpperCase();
        this.lowerName = sName.toLowerCase();
    }).CONSONANTS = ["B", "C", "D", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Z"];
} // end if
#endinitclip
