package leetcode

// @leet start
func twoSum(nums []int, target int) []int {
	hash := make(map[int]int)

	for i, num := range nums {
		if _, ok := hash[target-num]; ok {
			return []int{hash[target-num], i}
		}

		hash[nums[i]] = i
	}
	return nil
}

// @leet end

// Keynold
