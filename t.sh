#!/bin/bash

#PR_NUMBER=8846
#REPO=thunderbird/thunderbird-android

PR_NUMBER=3
GITHUB_REPOSITORY=kewisch/test2

gh api graphql -F repoOwner="${GITHUB_REPOSITORY%/*}" -F repoName="${GITHUB_REPOSITORY#*/}" -F prNumber="$PR_NUMBER" -f query='
  query($repoOwner: String!, $repoName: String!, $prNumber: Int!) {
    repository(owner: $repoOwner, name: $repoName) {
      pullRequest(number: $prNumber) {
        closingIssuesReferences(first: 100) {
          nodes {
            number
          }
        }
      }
    }
  }' --jq '.data.repository.pullRequest.closingIssuesReferences.nodes.[].number'


ACTIVE_MILESTONE=$(gh api repos/$GITHUB_REPOSITORY/milestones --jq '
      map(select(.state == "open" and .due_on != null))
      | sort_by(.due_on) | reverse
      | .[0].number' 2>/dev/null || echo "")

echo $ACTIVE_MILESTONE
# hi
#hi
