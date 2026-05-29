# title: Conventional Commit
$type = choice(feat|fix|docs|style|refactor|perf|test|chore)
$scope = concat('(', choice(lorem|ipsum|dolor), ')')

{{$type}}{{opt($scope, 0.4)}}: {{words(3-7)}}
