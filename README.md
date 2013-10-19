Sparsify Challenge
==================

Open to Cascadia Ruby 2013 attendees.

Nested-hash data structures are *awesome*, except that they are actually
pretty terrible to deal with when it comes to most data-stores. Sparsify is a
utility we use internally at Simply Measured that converts deeply-nested
hashes into flat, separator-concatenated-key hashes, like this:

``` ruby
# Nested Hash:
{
  'id'          => '196302235',
  'screen_name' => '@cascadiaruby',
  'counts'      => {
    'followers'   => 527,
    'following'   => 322,
    'listed'      => 41,
    'statuses'    => 1022
  },
  'meta'        => {
    'updated_at'  => '2013-10-17T03:36:17Z',
    'created_at'  => '2010-09-28T20:21:29Z'
  }
}

# Sparse Hash:
{
  'id'                => '196302235',
  'screen_name'       => '@cascadiaruby',
  'counts.followers'  => 527,
  'counts.following'  => 322,
  'counts.listed'     => 41,
  'counts.statuses'   => 1022,
  'meta.updated_at'   => '2013-10-17T03:36:17Z',
  'meta.created_at'   => '2010-09-28T20:21:29Z'
}
```

The challenge is to build your own:

Begin with `step-1`:

 1. run `rake step-1`
 2. code until the specs pass (The spec itself also contains hints)
 3. commit your changes.

Once you complete `step-1`, you will advance to `step-2` and
repeat. Each step includes the specs for all previous steps to ensure
you don't accidentally regress; there are currently 5 total steps.

*Don't forget to commit after each step is complete*. When you're done,
push your branch up to github and submit a pull-request. We'll look
through the results, score based on clarity, completeness, and style,
and notify prize-winners by 17:00 PDT on Tuesday, October 22.

Good luck!
