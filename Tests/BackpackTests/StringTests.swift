import XCTest
@testable import Backpack

final class StringTests: XCTestCase {

    // MARK: - Random Alphanumeric Tests

    func testRandomAlphaNumericLength() throws {
        let length = 10
        let randomString = String.randomAlphaNumeric(length: length)

        XCTAssertEqual(randomString.count, length)
    }

    func testRandomAlphaNumericContainsOnlyValidCharacters() throws {
        let randomString = String.randomAlphaNumeric(length: 100)
        let validCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890")

        for char in randomString.unicodeScalars {
            XCTAssertTrue(validCharacters.contains(char), "Character \(char) is not valid")
        }
    }

    func testRandomAlphaNumericIsRandom() throws {
        let string1 = String.randomAlphaNumeric(length: 20)
        let string2 = String.randomAlphaNumeric(length: 20)

        // Should be different (extremely unlikely to be the same)
        XCTAssertNotEqual(string1, string2)
    }

    func testRandomAlphaNumericZeroLength() throws {
        let randomString = String.randomAlphaNumeric(length: 0)

        XCTAssertEqual(randomString.count, 0)
        XCTAssertTrue(randomString.isEmpty)
    }

    func testRandomAlphaNumericLargeLength() throws {
        let length = 1000
        let randomString = String.randomAlphaNumeric(length: length)

        XCTAssertEqual(randomString.count, length)
    }

    // MARK: - Lorem Ipsum Tests

    func testLoremIpsumBasic() throws {
        let lorem = String.lorem

        XCTAssertFalse(lorem.isEmpty)
        XCTAssertTrue(lorem.contains("Lorem ipsum"))
    }

    func testLoremIpsumSingleParagraph() throws {
        let lorem = String.lorem(paragraphs: 1)

        XCTAssertFalse(lorem.isEmpty)
        XCTAssertTrue(lorem.contains("Lorem ipsum"))
        // Single paragraph should not have double newlines
        XCTAssertFalse(lorem.contains("\n\n"))
    }

    func testLoremIpsumMultipleParagraphs() throws {
        let lorem = String.lorem(paragraphs: 3)

        XCTAssertFalse(lorem.isEmpty)
        XCTAssertTrue(lorem.contains("Lorem ipsum"))
        // Multiple paragraphs should have double newlines between them
        XCTAssertTrue(lorem.contains("\n\n"))
    }

    func testLoremIpsumZeroParagraphs() throws {
        let lorem = String.lorem(paragraphs: 0)

        XCTAssertTrue(lorem.isEmpty)
    }

    func testLoremIpsumParagraphCount() throws {
        let singleParagraph = String.lorem(paragraphs: 1)
        let threeParagraphs = String.lorem(paragraphs: 3)

        // Three paragraphs should be longer than one
        XCTAssertTrue(threeParagraphs.count > singleParagraph.count)

        // Count occurrences of "Lorem ipsum" to verify paragraph count
        let pattern = "Lorem ipsum"
        let singleCount = singleParagraph.components(separatedBy: pattern).count - 1
        let tripleCount = threeParagraphs.components(separatedBy: pattern).count - 1

        XCTAssertEqual(singleCount, 1)
        XCTAssertEqual(tripleCount, 3)
    }

    // MARK: - Hashtag Extraction Tests

    func testHashtagsBasic() throws {
        let text = "Hello #world this is #awesome"
        let hashtags = text.hashtags()

        XCTAssertEqual(hashtags.count, 2)
        XCTAssertTrue(hashtags.contains("#world"))
        XCTAssertTrue(hashtags.contains("#awesome"))
    }

    func testHashtagsWithoutHashmark() throws {
        let text = "Hello #world this is #awesome"
        let hashtags = text.hashtags(maintainingHashmark: false)

        XCTAssertEqual(hashtags.count, 2)
        XCTAssertTrue(hashtags.contains("world"))
        XCTAssertTrue(hashtags.contains("awesome"))
        XCTAssertFalse(hashtags.contains("#world"))
    }

    func testHashtagsWithNumbers() throws {
        let text = "Check out #iOS17 and #swift6"
        let hashtags = text.hashtags()

        XCTAssertEqual(hashtags.count, 2)
        XCTAssertTrue(hashtags.contains("#ios17"))
        XCTAssertTrue(hashtags.contains("#swift6"))
    }

    func testHashtagsCaseInsensitive() throws {
        let text = "Hello #WORLD and #World"
        let hashtags = text.hashtags()

        // Should be lowercased
        XCTAssertTrue(hashtags.contains("#world"))
        XCTAssertFalse(hashtags.contains("#WORLD"))
        XCTAssertFalse(hashtags.contains("#World"))
    }

    func testHashtagsNoHashtags() throws {
        let text = "This has no hashtags at all"
        let hashtags = text.hashtags()

        XCTAssertEqual(hashtags.count, 0)
        XCTAssertTrue(hashtags.isEmpty)
    }

    func testHashtagsMultipleConsecutive() throws {
        let text = "#one#two#three"
        let hashtags = text.hashtags()

        XCTAssertEqual(hashtags.count, 3)
        XCTAssertTrue(hashtags.contains("#one"))
        XCTAssertTrue(hashtags.contains("#two"))
        XCTAssertTrue(hashtags.contains("#three"))
    }

    func testHashtagsWithSpecialCharacters() throws {
        let text = "#hello! #world? #test."
        let hashtags = text.hashtags()

        // Special characters should not be included in hashtags
        XCTAssertTrue(hashtags.contains("#hello"))
        XCTAssertTrue(hashtags.contains("#world"))
        XCTAssertTrue(hashtags.contains("#test"))
    }

    func testHashtagsWithUnderscore() throws {
        let text = "#hello_world"
        let hashtags = text.hashtags()

        // Underscores are not included in the regex pattern [a-z0-9]
        // So it should only match up to the underscore
        XCTAssertTrue(hashtags.contains("#hello"))
    }

    func testHashtagsEmptyString() throws {
        let text = ""
        let hashtags = text.hashtags()

        XCTAssertEqual(hashtags.count, 0)
        XCTAssertTrue(hashtags.isEmpty)
    }

    func testHashtagsOnlyHashSymbol() throws {
        let text = "Just a # symbol"
        let hashtags = text.hashtags()

        // A lone # without alphanumeric characters shouldn't match
        XCTAssertEqual(hashtags.count, 0)
    }

    func testHashtagsAtStartAndEnd() throws {
        let text = "#start some text #end"
        let hashtags = text.hashtags()

        XCTAssertEqual(hashtags.count, 2)
        XCTAssertTrue(hashtags.contains("#start"))
        XCTAssertTrue(hashtags.contains("#end"))
    }

    func testHashtagsWithNewlines() throws {
        let text = """
        First line #tag1
        Second line #tag2
        Third line #tag3
        """
        let hashtags = text.hashtags()

        XCTAssertEqual(hashtags.count, 3)
        XCTAssertTrue(hashtags.contains("#tag1"))
        XCTAssertTrue(hashtags.contains("#tag2"))
        XCTAssertTrue(hashtags.contains("#tag3"))
    }

    func testHashtagsDuplicates() throws {
        let text = "#duplicate #unique #duplicate"
        let hashtags = text.hashtags()

        // Array should contain duplicates (it's not a Set)
        XCTAssertEqual(hashtags.count, 3)
        let duplicateCount = hashtags.filter { $0 == "#duplicate" }.count
        XCTAssertEqual(duplicateCount, 2)
    }

    func testHashtagsLongHashtag() throws {
        let text = "#thisisaverylonghashtagwithmanycharacters123456789"
        let hashtags = text.hashtags()

        XCTAssertEqual(hashtags.count, 1)
        XCTAssertTrue(hashtags[0].contains("thisisaverylonghashtagwithmanycharacters123456789"))
    }
}
