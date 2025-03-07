#!/bin/bash

PR_NUMBER=8846
REPO=thunderbird/thunderbird-android

gh api graphql -F repoOwner="${REPO%/*}" -F repoName="${REPO#*/}" -F prNumber="$PR_NUMBER" -f query='
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

